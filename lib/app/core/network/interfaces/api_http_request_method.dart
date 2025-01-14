/// Enum representando os métodos HTTP utilizados nas requisições da API.
///
/// Pode ser usado para especificar o tipo de operação HTTP sendo executada.
enum ApiHttpRequestMethod {
  /// Método HTTP GET, tipicamente usado para recuperar dados de um servidor.
  get,

  /// Método HTTP POST, tipicamente usado para enviar dados a um servidor para criar um recurso.
  post,

  /// Método HTTP DELETE, tipicamente usado para remover um recurso de um servidor.
  delete,

  /// Método HTTP PUT, tipicamente usado para atualizar ou substituir um recurso no servidor.
  put,
}
