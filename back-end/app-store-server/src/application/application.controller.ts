import {
  Controller,
  DefaultValuePipe,
  Get,
  HttpStatus,
  Param,
  ParseIntPipe,
  Query,
} from '@nestjs/common';
import { PaginationTypeEnum } from 'nestjs-typeorm-paginate';
import responseModel, { buildResponseModel } from '../common/responseModel';
import { ApplicationService } from './application.service';

@Controller('application')
export class ApplicationController {
  constructor(private applicationService: ApplicationService) {}

  @Get('/top')
  async getTopApps(
    @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number = 1,
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number = 10,
  ): Promise<responseModel> {
    const apps = await this.applicationService.getPopularApps({ page, limit });
    return buildResponseModel(HttpStatus.OK, 'top apps', apps);
  }

  @Get('/top/free')
  async getTopFreeApps(
    @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number = 1,
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number = 10,
  ): Promise<responseModel> {
    limit = limit > 100 ? 100 : limit;
    const { items, meta, links } = await this.applicationService.getTopFreeApps(
      { limit, page },
    );
    return buildResponseModel(HttpStatus.OK, 'top free apps', {
      items,
      meta,
      links,
    });
  }

  @Get('/categories')
  async getCategories(): Promise<responseModel> {
    const categories = await this.applicationService.getAllCategories();
    return buildResponseModel(HttpStatus.OK, `all categories`, categories);
  }

  @Get('/search/:text')
  async searchApps(
    @Param('text') text: string,
    @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number = 1,
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number = 10,
  ): Promise<responseModel> {
    limit = limit > 100 ? 100 : limit;
    const apps = await this.applicationService.searchApps(
      { limit, page },
      text,
    );
    return buildResponseModel(
      HttpStatus.OK,
      `resault for ${text} search`,
      apps,
    );
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
  async getAppsOfCategory(
    @Param('cat') cat: string,
    @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number = 1,
    @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number = 1,
  ): Promise<responseModel> {
    const apps = await this.applicationService.findAppByCategory(
      { page, limit, paginationType: PaginationTypeEnum.LIMIT_AND_OFFSET },
      cat,
    );
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
