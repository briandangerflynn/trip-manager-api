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
    update_status(trip)
  end

  private

  def update_status(trip)
    if trip.status == "Not Started"
      trip.update(status: "In Progress", start_time: Time.zone.now)
      render json: { trip: trip, success: "You've successfully checked in!"}
    elsif trip.status == "In Progress" && Time.zone.now > trip.etc
      trip.update(status: "Overdue")
      render json: { trip: trip }
    elsif trip.status == "In Progress" || trip.status == "Overdue"
      trip.update(status: "Complete", end_time: Time.zone.now)
      render json: { trip: trip, success: "You've successfully checked out!"}
    end
  end

  def trip_params
    params.permit(:user_id, :owner_id, :assignee_id, :status, :location, :eta, :etc)
  end
end
