import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ApplicationEntity } from './entity/application.entity';
import { ApplicationDesEntity } from './entity/applicationDes.entity';
import * as fs from 'fs';
import {
  IPaginationOptions,
  paginate,
  Pagination,
} from 'nestjs-typeorm-paginate';

@Injectable()
export class ApplicationService {
  constructor(
    @InjectRepository(ApplicationEntity)
    private readonly applicationRepo: Repository<ApplicationEntity>,
    @InjectRepository(ApplicationDesEntity)
    private readonly applicationDesRepo: Repository<ApplicationDesEntity>,
  ) {
    // Once open this comments and after that close that again
    // this.fillApplicationData(
    //   'src/application/res/apple.store.json',
    //   (err, apps: object[]) => {
    //     if (err) {
    //       console.log(err);
    //       return;
    //     }
    //     apps.forEach((app) => {
    //       this.applicationRepo.insert(app).then(console.log);
    //     });
    //   },
    // );
    // this.fillApplicationData(
    //   'src/application/res/apple.storedes.json',
    //   (err, apps: object[]) => {
    //     if (err) {
    //       console.log(err);
    //       return;
    //     }
    //     apps.forEach((app) => {
    //       this.applicationDesRepo.insert(app).then(console.log);
    //     });
    //   },
    // );
  }

  // just fill data base from json file (PRIVATE METHOD)
  private async fillApplicationData(filePath: string, cb) {
    fs.readFile(filePath, (err, fileData) => {
      if (err) {
        return cb && cb(err);
      }
      try {
        const application = JSON.parse(fileData.toString());
        return cb && cb(null, application);
      } catch (err) {
        return cb && cb(err);
      }
    });
  }

  // get all categories
  async getAllCategories() {
    // const categories = await this.applicationRepo.createQueryBuilder('ApplicationEntity').select(['prime_genre']).distinct(true).getMany();
    // return categories;
    const cats = [];
    await this.applicationRepo
      .query('SELECT DISTINCT prime_genre FROM public.applications;')
      .then((val) => cats.push(val));
    return cats;
  }

  // find spesific apps by prime_genre value
  async findAppByCategory(
    options: IPaginationOptions,
    prime_genre: string,
  ): Promise<Pagination<ApplicationEntity>> {
    // return await this.applicationRepo.find({ where: { prime_genre } });
    // return await paginate<ApplicationEntity>(this.applicationRepo,options,{prime_genre});
    const query = this.applicationRepo
      .createQueryBuilder('app')
      .where('app.prime_genre = :genre', { genre: prime_genre });
    return await paginate<ApplicationEntity>(query, options);
  }

  // get all applications
  async getAllApplications(
    options: IPaginationOptions,
  ): Promise<Pagination<ApplicationEntity>> {
    const query = this.applicationRepo
      .createQueryBuilder('app')
      .orderBy('app.vpp_lic', 'DESC');
    return await paginate<ApplicationEntity>(query, options);
  }

  //get application by id
  async getApplicationById(id: number): Promise<ApplicationEntity> {
    return await this.applicationRepo.findOne({ id });
  }

  //get application details by id
  async getApplicationDesById(id: number): Promise<ApplicationDesEntity[]> {
    return await this.applicationDesRepo.find({ id });
  }

  // get top / free apps
  async getTopFreeApps(
    options: IPaginationOptions,
  ): Promise<Pagination<ApplicationEntity>> {
    const query = this.applicationRepo
      .createQueryBuilder('app')
      .where('app.price = :pr', { pr: '0' });
    return await paginate<ApplicationEntity>(query, options);
  }

  //get top apps
  async getPopularApps(
    options: IPaginationOptions,
  ): Promise<Pagination<ApplicationEntity>> {
    const apps = this.applicationRepo
      .createQueryBuilder('app')
      .distinct(true)
      .orderBy('app.rating_count_tot', 'DESC');
    return await paginate<ApplicationEntity>(apps, options);
  }

  //search apps
  async searchApps(
    options: IPaginationOptions,
    search: string,
  ): Promise<Pagination<ApplicationEntity>> {
    const query = this.applicationRepo
      .createQueryBuilder('app')
      .where('app.track_name Like :search', { search: `%${search}%` });
    return await paginate<ApplicationEntity>(query, options);
  }
}
