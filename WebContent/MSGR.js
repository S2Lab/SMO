function MSGR()
{
	this.msgs=new Array();
	this.setVal=function(nameIn,valueIn)
	{
		this.msgs.push(nameIn);
		this.msgs.push(valueIn);
	}
	this.getVal=function(nameIn)
	{
		let step=0;
		while(step<this.msgs.length)
		{
			if(this.msgs[step]==nameIn)
				return this.msgs[step+1];
			step+=2;
		}
		return null;
	}
	this.size=function()
	{
		return this.msgs.length/2;
	}
	this.toString=function()
	{
		let result="";
		
		let step=0
		while(step<this.msgs.length)
		{
			result+=this.msgs[step]+"|";
			step++;
		}
		
		return result;
	}
	this.fromString=function(str_in)
	{
		let result=new MSGR();
		if(str_in.trim().length=="")
			return result;
		
		let splits=str_in.split("|");
		let step=0;
		while(step<splits.length-1)
		{
			result.setVal(splits[step],splits[step+1]);
			step+=2;
		}
		
		return result;
	}
}