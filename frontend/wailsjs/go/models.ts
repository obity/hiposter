export namespace main {
	
	export class Result {
	    statusCode: number;
	    httpStatus: string;
	    bodyContent: string;
	    errorContent: string;
	
	    static createFrom(source: any = {}) {
	        return new Result(source);
	    }
	
	    constructor(source: any = {}) {
	        if ('string' === typeof source) source = JSON.parse(source);
	        this.statusCode = source["statusCode"];
	        this.httpStatus = source["httpStatus"];
	        this.bodyContent = source["bodyContent"];
	        this.errorContent = source["errorContent"];
	    }
	}

}

