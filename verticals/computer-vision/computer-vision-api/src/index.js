export class Service {
  constructor() {
    this.name = 'computer-vision-api';
    this.vertical = 'computer-vision';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
