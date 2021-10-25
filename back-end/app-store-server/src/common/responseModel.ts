import { HttpStatus } from '@nestjs/common';

// class bashe azin lahaz behtare ke yek field extra dar jayi bekhad beshe ezafe kard
class responseModel {
  //age dar constructor por nakonim dar response aslan vojud nakhahad dasht
  constructor(smessage?: string[], sdata?: any) {
    this.data = sdata ? sdata : {};
    this.message = smessage ? smessage : [];
  }
  public statusCode: any; //momkene typesh httpStatusCode
  public message: string[]; // default nest maslan entity ro khali bezarim message mide bedun 's' dar akhar
  public data: object;
  public error: any; //string
}

export function buildResponseModel(
  status: HttpStatus,
  msg: string,
  data: any,
): responseModel {
  const resp = new responseModel();
  resp.statusCode = status;
  resp.message.push(msg);
  resp.data = data;
  return resp;
}

export default responseModel;
