import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ApplicationEntity } from './entity/application.entity';
import { ApplicationDesEntity } from './entity/applicationDes.entity';

@Injectable()
export class ApplicationService {
    constructor(
        @InjectRepository(ApplicationEntity)
        private readonly applicationRepo: Repository<ApplicationEntity>,
        @InjectRepository(ApplicationDesEntity)
        private readonly applicationDesRepo: Repository<ApplicationDesEntity>,
    ) {}

    async getAllApplications(): Promise<ApplicationEntity> {
        return null;
    }

    async getApplicationById(id: number): Promise<ApplicationEntity[]> {
        return await this.applicationRepo.find({ id });
    }

    async getApplicationDesById(id: number): Promise<ApplicationDesEntity[]> {
        return await this.applicationDesRepo.find({ id });
    }
}
