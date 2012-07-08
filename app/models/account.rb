class Account < ActiveRecord::Base

	attr_accessor :stripe_card_token
  attr_accessible :tier, :title, :stripe_card_token
  validates :title, :presence => true

  has_and_belongs_to_many :projects
  has_many :subscriptions
  has_many :users, :through => :subscriptions

	def save_with_payment
	  if valid?
	  	binding.pry
	    customer = Stripe::Customer.create(description: title, plan: tier, card: stripe_card_token)
	    self.stripe_customer_token = customer.id
	    save!
	  end
	rescue Stripe::InvalidRequestError => e
	  logger.error "Stripe error while creating customer: #{e.message}"
	  errors.add :base, "There was a problem with your credit card."
	  false
	end

end