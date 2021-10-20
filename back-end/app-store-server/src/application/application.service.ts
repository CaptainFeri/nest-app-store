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
}
