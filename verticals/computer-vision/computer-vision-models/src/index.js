export class Service {
  constructor() {
    this.name = 'computer-vision-models';
    this.vertical = 'computer-vision';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
