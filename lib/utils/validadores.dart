final RegExp _patronCorreo = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

bool esCorreoValido(String correo) => _patronCorreo.hasMatch(correo);
