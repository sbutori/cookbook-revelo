class Api::V1::ApiController  < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # SHOW -achei e nao achei por id
  # CREATE - mandei, mandei algum em branco, mandei params nenhum
  # UPDATE - " "
  # DELETE - deletei, tentei deletar e nao achei
  def not_found
    render json: { message: 'Objeto não encontrado' }, status: :not_found
  end
end