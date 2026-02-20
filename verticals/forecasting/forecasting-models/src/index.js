export class Service {
  constructor() {
    this.name = 'forecasting-models';
    this.vertical = 'forecasting';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
