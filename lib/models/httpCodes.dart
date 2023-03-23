
// ignore_for_file: constant_identifier_names

class StatusCodes {
  // 1xx Informational
  static const Continue = 100;
  static const SwitchingProtocols = 101;
  static const Processing = 102;
  static const EarlyHints = 103;

  // 2xx Success
  static const OK = 200;
  static const Created = 201;
  static const Accepted = 202;
  static const NonAuthoritativeInformation = 203;
  static const NoContent = 204;
  static const ResetContent = 205;
  static const PartialContent = 206;
  static const MultiStatus = 207;

  // 3xx Redirection
  static const MultipleChoices = 300;
  static const MovedPermanently = 301;
  static const Found = 302;
  static const SeeOther = 303;
  static const NotModified = 304;
  static const UseProxy = 305;
  static const TemporaryRedirect = 307;
  static const PermanentRedirect = 308;

  // 4xx Client Error
  static const BadRequest = 400;
  static const Unauthorized = 401;
  static const PaymentRequired = 402;
  static const Forbidden = 403;
  static const NotFound = 404;
  static const MethodNotAllowed = 405;
  static const NotAcceptable = 406;
  static const ProxyAuthenticationRequired = 407;
  static const RequestTimeout = 408;
  static const Conflict = 409;
  static const Gone = 410;
  static const LengthRequired = 411;
  static const PreconditionFailed = 412;
  static const PayloadTooLarge = 413;
  static const URITooLong = 414;
  static const UnsupportedMediaType = 415;
  static const RangeNotSatisfiable = 416;
  static const ExpectationFailed = 417;

  // 5xx Server Error
  static const InternalServerError = 500;
  static const NotImplemented = 501;
  static const BadGateway = 502;
  static const ServiceUnavailable = 503;
  static const GatewayTimeout = 504;
  static const HTTPVersionNotSupported = 505;
  static const VariantAlsoNegotiates = 506;
  static const InsufficientStorage = 507;

  // method get the status code message
  static String getMessage(int code) {
    switch (code) {
      case 100:
        return 'Continue';
      case 101:
        return 'Switching Protocols';
      case 200:
        return 'OK';
      case 201:
        return 'Created';
      case 202:
        return 'Accepted';
      case 203:
        return 'Non-Authoritative Information';
      case 204:
        return 'No Content';
      case 205:
        return 'Reset Content';
      case 206:
        return 'Partial Content';
      case 300:
        return 'Multiple Choices';
      case 301:
        return 'Moved Permanently';
      case 302:
        return 'Found';
      case 303:
        return 'See Other';
      case 304:
        return 'Not Modified';
      case 305:
        return 'Use Proxy';
      case 307:
        return 'Temporary Redirect';
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 402:
        return 'Payment Required';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 405:
        return 'Method Not Allowed';
      case 406:
        return 'Not Acceptable';
      case 407:
        return 'Proxy Authentication Required';
      case 408:
        return 'Request Timeout';
      case 409:
        return 'Conflict';
      case 410:
        return 'Gone';
      case 411:
        return 'Length Required';
      case 412:
        return 'Precondition Failed';
      case 413:
        return 'Request Entity Too Large';
      case 414:
        return 'Request-URI Too Long';
      case 415:
        return 'Unsupported Media Type';
      case 416:
        return 'Requested Range Not Satisfiable';
      case 417:
        return 'Expectation Failed';
      case 500:
        return 'Internal Server Error';
      case 501:
        return 'Not Implemented';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      case 505:
        return 'HTTP Version Not Supported';
      default:
        return 'Unknown status code';
    }
  }
}
