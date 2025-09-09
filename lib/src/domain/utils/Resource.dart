abstract class Resource<T> {}

class Loading<T> extends Resource<T> {}

class Success<T> extends Resource<T> {
  // T no sabe que tipo de dato va a recibir
  // por eso se define en el momento de la creación
  final T data;
  Success(this.data);
}

class ErrorData<T> extends Resource<T> {
  final String message;
  ErrorData(this.message);
} 

