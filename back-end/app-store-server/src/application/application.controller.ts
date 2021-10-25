import { Controller, Get, HttpStatus, Param } from '@nestjs/common';
import responseModel, { buildResponseModel } from 'src/common/responseModel';
import { ApplicationService } from './application.service';

@Controller('application')
export class ApplicationController {
  constructor(private readonly applicationService: ApplicationService) {}

  @Get('/info/:id')
  async getAppInfo(@Param('id') id: number): Promise<responseModel> {
    const app = await this.applicationService.getApplicationDesById(id);
    if (app) {
      return buildResponseModel(HttpStatus.OK, `app by ${id}`, app);
    }
    return buildResponseModel(
      HttpStatus.NOT_ACCEPTABLE,
      `app by ${id} not found`,
      id,
    );
  }
}
