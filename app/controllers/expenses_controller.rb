class ExpensesController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @expenses = @trip.expenses
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.find(params[:id])
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @expense = Expense.new
  end
  def create
    @trip = Trip.find(params[:trip_id])
    @expense = Trip.new(expense_params)
    @expense.trip = @trip
  end


  def edit
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.find(params[:id])

    if @expense.update_attributes(expense_params)
      flash[:notice] = "Expense was updated successfully"
      redirect_to trip_expenses(@trip)
    else
      flash[:error] = "Sorry, there was some problem in updating your expense. Please try again"
      redirect_to trip_expenses(@trip)
    end
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.find(params[:id])

    if @expense.destroy
      flash[:notice] = "Expense was deleted successfully"
      redirect_to trip_expenses(@trip)
    else
      flash[:error] = "Sorry, there was some problem in deleting your expense. Please try again"
      redirect_to trip_expenses(@trip)
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:category, :amount_spent)
  end

end
