class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  statuses = %w(PENDING APPROVED DENIED)
  validates :status, presence: true, inclusion: {in: statuses }
  #validates [:cat, :status], uniqueness: true
  before_validation(on: :create) do
    self.status ||= 'PENDING'
  end
  belongs_to :cat
  has_one :user, through: :cat, source: :user

  def overlapping_requests
    query = "cat_id = #{self.cat_id}
      AND ((start_date::DATE, end_date::DATE)
      OVERLAPS ('#{self.start_date}'::DATE, '#{self.end_date}'::DATE))"
    overlapping_reqs = CatRentalRequest.where(query)
    overlapping_reqs - [self]
  end

  def overlapping_approved_requests
    overlapping_requests.select{|ol_request| ol_request.status.upcase == 'APPROVED' }
  end

  def overlapping_pending_requests
    overlapping_requests.select{|ol_request| ol_request.status.upcase == 'PENDING' }
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED" if overlapping_approved_requests.empty?
      overlapping_pending_requests.each { |request| request.deny! }
      self.save!
    end
  end

  def deny!
    CatRentalRequest.transaction do
      self.status = "DENIED"
      self.save!
    end
  end


end