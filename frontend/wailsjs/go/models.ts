export namespace main {
	
	export class Header {
	    key: string;
	    value: string;
	
	    static createFrom(source: any = {}) {
	        return new Header(source);
	    }
	
	    constructor(source: any = {}) {
	        if ('string' === typeof source) source = JSON.parse(source);
	        this.key = source["key"];
	        this.value = source["value"];
	    }
	}
	export class Result {
	    statusCode: number;
	    httpStatus: string;
	    bodyContent: string;
	    errorContent: string;
	    contentType: string;
	
	    static createFrom(source: any = {}) {
	        return new Result(source);
	    }
	
	    constructor(source: any = {}) {
	        if ('string' === typeof source) source = JSON.parse(source);
	        this.statusCode = source["statusCode"];
	        this.httpStatus = source["httpStatus"];
	        this.bodyContent = source["bodyContent"];
	        this.errorContent = source["errorContent"];
	        this.contentType = source["contentType"];
	    }
	}

}

