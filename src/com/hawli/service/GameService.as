package com.hawli.service
{
	import com.hawli.controller.events.ServiceEvent;
	import com.hawli.model.Cryptage;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.model.vo.SettingVo;
	
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.net.registerClassAlias;
	
	import org.robotlegs.mvcs.Actor;

/**
 *  class to communication with the  AMF server , send and retrieve
 */
	
	public class GameService extends Actor{
		
		private var _netConnection:NetConnection;
		private static var OUTSIDE_SERVICE_URL:String = "http://"+SettingVo.SERVER+"/jawla/hawli/amf/services/"//"http://192.168.1.2/jawla/hawli2/amf/services/";//"http://www.fb-concours.com/jawla/hawli2/amf/services/"//"http://www.fb-concours.com/jawla/hawli/amf/services/"; 
		private var responder:Responder = new Responder(onResult,onFault);
		
		public function GameService(){
			super();
			registerClassAlias("OperationVo",OperationVo);
			registerClassAlias("HawliVo",HawliVo);
			_netConnection = new NetConnection();
			_netConnection.objectEncoding = ObjectEncoding.DEFAULT;
			_netConnection.connect(OUTSIDE_SERVICE_URL);
		}
		
		public  function createHawli(hawli:HawliVo):void{
			
			_netConnection.call("HawliServices/createHawli",new Responder(onCreateHawliCompleted,null),hawli);
		}
		
		public  function getClassement():void{
			_netConnection.call("HawliServices/getClassement",new Responder(onGetClassementCompleted,null));
		}
		
		protected  function onGetClassementCompleted(result:Object):void{
			//var listHawli:Array = (result as Array);
			this.dispatch(new ServiceEvent(ServiceEvent.CLASSEMENT_RECIEVED,result));
		}
		
		public  function getHawliInfo(idUser:int):void{
			_netConnection.call("HawliServices/getHawliInfo",new Responder(onGetHawliInfoCompleted,null),Cryptage.encrypt(String(idUser)));
		}
		
		protected  function onGetHawliInfoCompleted(result:Object):void{
			//var hawli:HawliVo = HawliVo(result);
			this.dispatch(new ServiceEvent(ServiceEvent.HAWLI_DATA_RECIEVED,result));
		}
		
		public  function userHaveHawli(idUser:int,session:String):void{
			_netConnection.call("HawliServices/userHaveHawli",new Responder(onUserHaveHawliCompleted,null),Cryptage.encrypt(String(idUser)),session);
		}
		
		public   function updateCash(idUser:int,cash:int):void{
			_netConnection.call("HawliServices/updateCash", responder ,Cryptage.encrypt(String(idUser)),Cryptage.encrypt(String(cash)));
		}
		
		public  function updateDog(idUser:int,id:int,cash:int):void{
			
			_netConnection.call("HawliServices/updateKelb", responder ,Cryptage.encrypt(String(idUser)),id,Cryptage.encrypt(String(cash)));
		}
		
		protected  function onUserHaveHawliCompleted(result:Object):void{
			//var haveHawli:Boolean = int(result)==1;
			this.dispatch(new ServiceEvent(ServiceEvent.HAVE_HAWLI_RECIEVED,result));
		}
		
		protected  function onCreateHawliCompleted(result:Object):void{
			//var haveHawli:Boolean = int(result)==1;
			this.dispatch(new ServiceEvent(ServiceEvent.CREATE_HAWLI_RECIEVED,result));
		}
		
		public  function sendOperation(operation:OperationVo):void{
			operation.idUser=Cryptage.encrypt(String(operation.idUser));
			_netConnection.call("HawliServices/sendOperation",responder,operation);
		}
		
		public  function changeState(idUser:int,state:int):void{
			_netConnection.call("HawliServices/changeState",responder,Cryptage.encrypt(String(idUser)),state);
		}
		public  function updateInvidIds(idUser:int,request:int,ids:Array):void{
			var string:String=ids.join(",");
			_netConnection.call("HawliServices/createInvite", responder ,Cryptage.encrypt(String(idUser)),request,string);
		}
		protected  function onResult(result:Object):void{
			trace(result);
		}
		
		protected  function onFault(fault:String):void{
			trace(fault);
		}
	}
}