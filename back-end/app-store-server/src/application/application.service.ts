import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ApplicationEntity } from './entity/application.entity';
import { ApplicationDesEntity } from './entity/applicationDes.entity';
import * as fs from 'fs';
@Injectable()
export class ApplicationService {
  constructor(
    @InjectRepository(ApplicationEntity)
    private readonly applicationRepo: Repository<ApplicationEntity>,
    @InjectRepository(ApplicationDesEntity)
    private readonly applicationDesRepo: Repository<ApplicationDesEntity>,
  ) {
    // Once open this comments and after that close that again

    // this.fillApplicationData('src/application/res/apple.store.json',(err,apps: object[]) => {
    //   if(err) {
    //     console.log(err);
    //     return;
    //   }
    //   apps.forEach((app) => {
    //     this.applicationRepo.insert(app);
    //     console.log(`app inserted: ${app}`);
    //   })
    // })

    // this.fillApplicationData('src/application/res/apple.store.description.json',(err,apps: object[]) => {
    //   if(err) {
    //     console.log(err);
    //     return;
    //   }
    //   apps.forEach((app) => {
    //     this.applicationDesRepo.insert(app);
    //     console.log(`app inserted: ${app}`);
    //   })
    // })
  }

  private async fillApplicationData(filePath : string,cb) {
    fs.readFile(filePath, (err,fileData) => {
      if(err) {
        return cb && cb(err);
      }
      try {
        const application = JSON.parse(fileData.toString())
        return cb && cb(null,application);
      } catch(err) {
        return cb && cb(err);
      }
    })
  }

  async getAllApplications(): Promise<ApplicationEntity[]> {
    return await this.applicationRepo.find();
  }

  async getApplicationById(id: number): Promise<ApplicationEntity[]> {
    return await this.applicationRepo.find({ id });
  }

  async getApplicationDesById(id: number): Promise<ApplicationDesEntity[]> {
    return await this.applicationDesRepo.find({ id });
  }
}
