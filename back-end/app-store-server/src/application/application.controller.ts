import { Controller, Get, HttpStatus, Param } from '@nestjs/common';
import responseModel, { buildResponseModel } from 'src/common/responseModel';
import { ApplicationService } from './application.service';

@Controller('application')
export class ApplicationController {
  constructor(private applicationService: ApplicationService) {}

  @Get('/top')
  async getTopApps(): Promise<responseModel> {
    const apps = await this.applicationService.getPopularApps();
    const resp = new responseModel();
    resp.data = apps;
    resp.message.push('top free apps');
    resp.statusCode = HttpStatus.OK;
    resp.error = null;
    return resp;
  }

  @Get('/top/free')
  async getTopFreeApps(): Promise<responseModel> {
    const apps = await this.applicationService.getTopFreeApps();
    const resp = new responseModel();
    resp.data = apps;
    resp.message.push('top free apps');
    resp.statusCode = HttpStatus.OK;
    resp.error = null;
    return resp;
  }

  @Get('/categories')
  async getCategories(): Promise<responseModel> {
    const categories = await this.applicationService.getAllCategories();
    return buildResponseModel(HttpStatus.OK, `all categories`, categories);
  }
  
  @Get('/search/:text')
  async searchApps(@Param('text') text: string): Promise<responseModel> {
    const apps = await this.applicationService.searchApps(text);
    const resp = new responseModel();
    resp.data = apps;
    resp.message.push(`resault for ${text} search`);
    resp.statusCode = HttpStatus.OK;
    resp.error = null;
    return resp;
  }


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

  @Get('/:id')
  async getApp(@Param('id') id: number): Promise<responseModel> {
    const app = await this.applicationService.getApplicationById(id);
    if (app) {
      return buildResponseModel(HttpStatus.OK, `app by ${id}`, app);
    }
    return buildResponseModel(
      HttpStatus.NOT_ACCEPTABLE,
      `app by ${id} not found`,
      id,
    );
  }

  @Get('/category/:cat')
  async getAppsOfCategory(@Param('cat') cat: string): Promise<responseModel> {
    const apps = await this.applicationService.findAppByCategory(cat);
    if (apps) {
      return buildResponseModel(HttpStatus.OK, `app by ${cat} category`, apps);
    }
    return buildResponseModel(
      HttpStatus.NOT_ACCEPTABLE,
      `${cat} category NOt Found`,
      cat,
    );
  }
}
