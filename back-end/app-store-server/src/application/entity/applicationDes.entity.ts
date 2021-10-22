import { Column, CreateDateColumn, DeleteDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';

@Entity({ name: 'app-des' })
export class ApplicationDesEntity {
  @Column()
  id: number;
  @PrimaryGeneratedColumn()
  app_id: number;
  @Column()
  app_desc: string;
  @CreateDateColumn({
    type: 'time with time zone'
  })
  createddate: string;
  @UpdateDateColumn({
    type: 'time with time zone'
  })
  updateddate: string;
  @DeleteDateColumn({
    type: 'time with time zone'
  })
  deleteddate: string;
}
