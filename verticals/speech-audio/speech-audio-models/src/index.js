export class Service {
  constructor() {
    this.name = 'speech-audio-models';
    this.vertical = 'speech-audio';
  }
  async execute(data) {
    return { success: true, service: this.name, data };
  }
}
export default Service;
