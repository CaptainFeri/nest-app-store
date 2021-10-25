import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Like, Repository } from 'typeorm';
import { ApplicationEntity } from './entity/application.entity';
import { ApplicationDesEntity } from './entity/applicationDes.entity';
import * as fs from 'fs';
import { runInThisContext } from 'vm';
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

  // view spesific app info by app_id
  async viewAppInfo(id: number): Promise<ApplicationDesEntity> {
    const app = await this.applicationDesRepo.findOne({ id });
    if (app) {
      return app;
    }
    return null;
  }

  // get all categories
  async getAllCategories() {
    await this.applicationRepo
      .query('SELECT DISTINCT prime_genre FROM public.applications;')
      .then((val) => console.log(val));
  }

  // find spesific apps by prime_genre value
  async findAppByCategory(prime_genre: string): Promise<ApplicationEntity[]> {
    return await this.applicationRepo.find({ where: { prime_genre } });
  }

  // get all applications
  async getAllApplications(): Promise<ApplicationEntity[]> {
    return await this.applicationRepo.find();
  }

  //get application by id
  async getApplicationById(id: number): Promise<ApplicationEntity[]> {
    return await this.applicationRepo.find({ id });
  }

  //get application details by id
  async getApplicationDesById(id: number): Promise<ApplicationDesEntity[]> {
    return await this.applicationDesRepo.find({ id });
  }

  // get top / free apps
  async getTopFreeApps(): Promise<ApplicationEntity[]> {
    const apps = await this.applicationRepo.find({
      where: {
        price: 0,
      },
    });
    if (apps.length > 0) {
      const sort_apps = apps.sort((a, b) =>
        a.rating_count_tot > b.rating_count_tot
          ? 1
          : b.rating_count_tot > a.rating_count_tot
          ? -1
          : 0,
      );
      return sort_apps;
    }
  }

  //get top apps
  async getPopularApps(): Promise<ApplicationEntity[]> {
    const apps = await this.applicationRepo.find();
    const sort_apps = apps.sort((a, b) =>
      a.rating_count_tot > b.rating_count_tot
        ? 1
        : b.rating_count_tot > a.rating_count_tot
        ? -1
        : 0,
    );
    return sort_apps;
  }


  //search apps
  async searchApp(search: string): Promise<ApplicationEntity[]> {
    const apps = await this.applicationRepo.find({
      where: {
        track_name: Like('%' + search + '%'),
      },
    });
    return apps;
  }
}
