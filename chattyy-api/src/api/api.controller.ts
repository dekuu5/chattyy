import { Controller, Get } from '@nestjs/common';

@Controller('api/v1')
export class ApiController {
    constructor() { }
    
    @Get("status")
    getStatus() {
        return { status: "ok" };
    }
}
