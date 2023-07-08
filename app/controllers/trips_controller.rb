class TripsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    trips = Trip.where(owner: user).or(Trip.where(assignee: user))
    render json: { trips: trips }
  end

  def create
    owner = User.find(params[:user_id])
    assignee = User.find(params[:assignee_id])
    trip = owner.trips_owned.build(trip_params.merge(owner_name: owner.fullname, assignee_name: assignee.fullname))

    if trip.save!
      render json: { trip: trip, success: "Trip Created!" }
    else
      render json: {message: "Error creating trip info."}
    end
  end

  def update
    trip = Trip.find(params[:id])
    trip.update(trip_params)

    render json: { trip: trip, success: "Trip updated!"}
  end

  def check_overdue
    user = User.find(params[:user_id])
    trips = Trip.where(owner: user).or(Trip.where(assignee: user))

    trips.each do |trip|
      if trip.status == "In Progress" && Time.zone.now > trip.etc
        trip.update(status: "Overdue")
      end
    end
    render json: { trips: trips }
  end

  def update_status
    trip = Trip.find(params[:id])

    if trip.status == "Not Started" && Time.zone.now > trip.etc
       trip.update(status: "Overdue", start_time: Time.zone.now)
       render json: { trip: trip, success: "You've checked in, but you're already overdue!"}
    elsif trip.status == "Not Started"
      trip.update(status: "In Progress", start_time: Time.zone.now)
      render json: { trip: trip, success: "You've successfully checked in!"}
    elsif trip.status == "In Progress" || trip.status == "Overdue"
      trip.update(status: "Complete", end_time: Time.zone.now)
      render json: { trip: trip, success: "You've successfully checked out!"}
    end
  end

  private

  def trip_params
    params.permit(:owner_id, :assignee_id, :status, :location, :eta, :etc, :owner_name, :assignee_name)
  end
end
