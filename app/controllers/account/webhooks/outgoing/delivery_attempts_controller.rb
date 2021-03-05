class Account::Webhooks::Outgoing::DeliveryAttemptsController < Account::ApplicationController
  account_load_and_authorize_resource :delivery_attempt, through: :delivery, through_association: :delivery_attempts

  # GET /account/webhooks/outgoing/deliveries/:delivery_id/webhooks/outgoing/delivery_attempts
  # GET /account/webhooks/outgoing/deliveries/:delivery_id/webhooks/outgoing/delivery_attempts.json
  def index
    # since we're showing delivery_attempts on the delivery show page by default,
    # we might as well just go there.
    redirect_to [:account, @delivery]
  end

  # GET /account/webhooks/outgoing/delivery_attempts/:id
  # GET /account/webhooks/outgoing/delivery_attempts/:id.json
  def show
  end

  # GET /account/webhooks/outgoing/deliveries/:delivery_id/webhooks/outgoing/delivery_attempts/new
  def new
  end

  # GET /account/webhooks/outgoing/delivery_attempts/:id/edit
  def edit
  end

  # POST /account/webhooks/outgoing/deliveries/:delivery_id/webhooks/outgoing/delivery_attempts
  # POST /account/webhooks/outgoing/deliveries/:delivery_id/webhooks/outgoing/delivery_attempts.json
  def create
    respond_to do |format|
      if @delivery_attempt.save
        format.html { redirect_to [:account, @delivery, :delivery_attempts], notice: I18n.t("webhooks/outgoing/delivery_attempts.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @delivery, @delivery_attempt] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @delivery_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/webhooks/outgoing/delivery_attempts/:id
  # PATCH/PUT /account/webhooks/outgoing/delivery_attempts/:id.json
  def update
    respond_to do |format|
      if @delivery_attempt.update(delivery_attempt_params)
        format.html { redirect_to [:account, @delivery_attempt], notice: I18n.t("webhooks/outgoing/delivery_attempts.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @delivery_attempt] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @delivery_attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/webhooks/outgoing/delivery_attempts/:id
  # DELETE /account/webhooks/outgoing/delivery_attempts/:id.json
  def destroy
    @delivery_attempt.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @delivery, :delivery_attempts], notice: I18n.t("webhooks/outgoing/delivery_attempts.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def delivery_attempt_params
    params.require(:webhooks_outgoing_delivery_attempt).permit(:response_code)
  end
end
