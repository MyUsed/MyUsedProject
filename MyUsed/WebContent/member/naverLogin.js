/*
* Jindo
* @type desktop
* @version 2.11.0
*
* NAVER Corp; JindoJS JavaScript Framework
* http://jindo.dev.naver.com/
*
* Released under the LGPL v2 license
* http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html
*
* Customized: Core,$$,$Agent,$H,$Fn,$Event,$Element,$Json,$Ajax
*/

var nv = window.nv||{};

nv._p_ = {};
nv._p_.nvName = "nv";

!function() {
    if(window[nv._p_.nvName]) {
        var __old_j = window[nv._p_.nvName];
        for(var x in __old_j) {
            nv[x] = __old_j[x];
        }
    }
}();

/**
	@fileOverview polyfill ����
	@name polyfill.js
	@author NAVER Ajax Platform
*/
function _settingPolyfill(target,objectName,methodName,polyfillMethod,force){
    if(force||!target[objectName].prototype[methodName]){
        target[objectName].prototype[methodName] = polyfillMethod;
    }
}

function polyfillArray(global){
    function checkCallback(callback){
        if (typeof callback !== 'function') {
            throw new TypeError("callback is not a function.");
        }
    }
    _settingPolyfill(global,"Array","forEach",function(callback, ctx){
        checkCallback(callback);
        var thisArg = arguments.length >= 2 ? ctx : void 0;
        for(var i = 0, l = this.length; i < l; i++){
            callback.call(thisArg, this[i], i, this);
        }
    });
    _settingPolyfill(global,"Array","every",function(callback, ctx){
        checkCallback(callback);
        var thisArg = arguments.length >= 2 ? ctx : void 0;
        for(var i = 0, l = this.length; i < l; i++){
            if(!callback.call(thisArg, this[i], i, this)) return false;
        }
        return true;
    });
}

if(!window.__isPolyfillTestMode){
    polyfillArray(window);
}

//  https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind
if (!Function.prototype.bind) {
    Function.prototype.bind = function (target) {
        if (typeof this !== "function") {
            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        }
        
        var arg = Array.prototype.slice.call(arguments, 1), 
        bind = this, 
        nop = function () {},
        wrap = function () {
            return bind.apply(
                nop.prototype && this instanceof nop && target ? this : target,
                arg.concat(Array.prototype.slice.call(arguments))
            );
        };
        
        nop.prototype = this.prototype;
        wrap.prototype = new nop();
        return wrap;
    };
}

function polyfillTimer(global){
    var agent = global.navigator.userAgent, isIOS = /i(Pad|Phone|Pod)/.test(agent), iOSVersion;
    
    if(isIOS){
        var matchVersion =  agent.match(/OS\s(\d)/);
        if(matchVersion){
            iOSVersion = parseInt(matchVersion[1],10);
        }
    }
    
    var raf = global.requestAnimationFrame || global.webkitRequestAnimationFrame || global.mozRequestAnimationFrame|| global.msRequestAnimationFrame,
        caf = global.cancelAnimationFrame || global.webkitCancelAnimationFrame|| global.mozCancelAnimationFrame|| global.msCancelAnimationFrame;
    
    if(raf&&!caf){
        var keyInfo = {}, oldraf = raf;

        raf = function(callback){
            function wrapCallback(){
                if(keyInfo[key]){
                    callback();
                }
            }
            var key = oldraf(wrapCallback);
            keyInfo[key] = true;
            return key;
        };

        caf = function(key){
            delete keyInfo[key];
        };
        
    } else if(!(raf&&caf)) {
        raf = function(callback) { return global.setTimeout(callback, 16); };
        caf = global.clearTimeout;
    }
    
    global.requestAnimationFrame = raf;
    global.cancelAnimationFrame = caf;
    
    
    // Workaround for iOS6+ devices : requestAnimationFrame not working with scroll event
    if(iOSVersion >= 6){
        global.requestAnimationFrame(function(){});
    }
    
    // for iOS6 - reference to https://gist.github.com/ronkorving/3755461
    if(iOSVersion == 6){
        var timerInfo = {},
            SET_TIMEOUT = "setTimeout",
            CLEAR_TIMEOUT = "clearTimeout",
            SET_INTERVAL = "setInterval",
            CLEAR_INTERVAL = "clearInterval",
            orignal = {
                "setTimeout" : global.setTimeout.bind(global),
                "clearTimeout" : global.clearTimeout.bind(global),
                "setInterval" : global.setInterval.bind(global),
                "clearInterval" : global.clearInterval.bind(global)
            };
        
        [[SET_TIMEOUT,CLEAR_TIMEOUT],[SET_INTERVAL,CLEAR_INTERVAL]].forEach(function(v){
            global[v[0]] = (function(timerName,clearTimerName){
                return function(callback,time){
                    var timer = {
                        "key" : "",
                        "isCall" : false,
                        "timerType" : timerName,
                        "clearType" : clearTimerName,
                        "realCallback" : callback,
                        "callback" : function(){
                            var callback = this.realCallback;
                            callback();
                            if(this.timerType === SET_TIMEOUT){
                                this.isCall = true;
                                 delete timerInfo[this.key];
                            }
                        },
                        "delay" : time,
                        "createdTime" : global.Date.now()
                    };
                    timer.key = orignal[timerName](timer.callback.bind(timer),time);
                    timerInfo[timer.key] = timer;
            
                    return timer.key;
                };
            })(v[0],v[1]);
            
            global[v[1]] = (function(clearTimerName){
                return function(key){
                    if(key&&timerInfo[key]){
                        orignal[clearTimerName](timerInfo[key].key);
                        delete timerInfo[key];
                    }
                };
            })(v[1]);
            
        });
        
        function restoreTimer(){
            var currentTime = global.Date.now();
            var newTimerInfo = {},gap;
            for(var  i in timerInfo){
                var timer = timerInfo[i];
                orignal[timer.clearType](timerInfo[i].key);
                delete timerInfo[i];
                
                if(timer.timerType == SET_TIMEOUT){
                    gap = currentTime - timer.createdTime;
                    timer.delay = (gap >= timer.delay)?0:timer.delay-gap;
                }
                
                if(!timer.isCall){
                    timer.key = orignal[timer.timerType](timer.callback.bind(timer),timer.delay);
                    newTimerInfo[i] = timer;
                }
                
                
            }
            timerInfo = newTimerInfo;
            newTimerInfo = null;
        }
        
        global.addEventListener("scroll",function(e){
            restoreTimer();
        });
    }

    return global;
}

if(!window.__isPolyfillTestMode){
    polyfillTimer(window);
}

//-!namespace.default start!-//
/**
	@fileOverview $() �Լ�, nv.$Jindo() ��ü, nv.$Class() ��ü�� ???���� ����.
	@name core.js
	@author NAVER Ajax Platform
 */
/**
 	agent�� dependency�� ���ֱ� ���� ������ ����.
	
	@ignore
 **/
nv._p_._j_ag = navigator.userAgent;
nv._p_._JINDO_IS_IE = /(MSIE|Trident)/.test(nv._p_._j_ag);  // IE
nv._p_._JINDO_IS_FF = nv._p_._j_ag.indexOf("Firefox") > -1;  // Firefox
nv._p_._JINDO_IS_OP = nv._p_._j_ag.indexOf("Opera") > -1;  // Presto engine Opera
nv._p_._JINDO_IS_SP = /Version\/[\d\.]+\s(?=Safari)/.test(nv._p_._j_ag);  // Safari
nv._p_._JINDO_IS_CH = /Chrome\/[\d\.]+\sSafari\/[\d\.]+$/.test(nv._p_._j_ag);  // Chrome
nv._p_._JINDO_IS_WK = nv._p_._j_ag.indexOf("WebKit") > -1;
nv._p_._JINDO_IS_MO = /(iPhone|iPod|Mobile|Tizen|Android|Nokia|webOS|BlackBerry|Opera Mobi|Opera Mini)/.test(nv._p_._j_ag);

nv._p_.trim = function(str){
    var sBlank = "\\s|\\t|"+ String.fromCharCode(12288), re = new RegExp(["^(?:", ")+|(?:", ")+$"].join(sBlank), "g");
    return str.replace(re, "");
};
//-!namespace.default end!-//

//-!nv.$Jindo.default start!-//
/**
	nv.$Jindo() ��ü�� �����ӿ�ũ�� ���� ������ ��ƿ��Ƽ �Լ��� �����Ѵ�.

	@class nv.$Jindo
	@keyword core, �ھ�, $Jindo
 */
/**
	nv.$Jindo() ��ü�� �����Ѵ�. nv.$Jindo() ��ü�� Jindo �����ӿ�ũ�� ���� ������ ��ƿ��Ƽ �Լ��� �����Ѵ�.
	
	@constructor
	@remark ������ Jindo �����ӿ�ũ ������ ��� �ִ� ��ü�� �Ӽ��� ������ ǥ�̴�.<br>
		<h5>Jindo �����ӿ�ũ ���� ��ü �Ӽ�</h5>
		<table class="tbl_board">
			<caption class="hide">Jindo �����ӿ�ũ ���� ��ü �Ӽ�</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">version</td>
					<td>Number</td>
					<td class="txt">Jindo �����ӿ�ũ�� ������ �����Ѵ�.</td>
				</tr>
		</table>
 */
nv.$Jindo = function() {
    //-@@$Jindo.default-@@//
    var cl=arguments.callee;
    var cc=cl._cached;

    if (cc) return cc;
    if (!(this instanceof cl)) return new cl();
    if (!cc) cl._cached = this;
};

nv._p_.addExtension = function(sClass,sMethod,fpFunction){
    // if(nv[sClass]){
    if(nv[sClass][sMethod]){
        nv.$Jindo._warn(sClass+"."+sMethod+" was overwrite.");
    }else{
        if(/^x/.test(sMethod)){
            nv[sClass][sMethod] = fpFunction;
        }else{
            nv.$Jindo._warn("The Extension Method("+sClass+"."+sMethod+") must be used with x prefix.");
        }
    }
};
/**
	ȣȯ ��带 �����ϰ� ��ȯ�ϴ� �Լ�.
	
	@method compatible
	@ignore
	@param {Boolean} bType
	@return {Boolean} [true | false]
 */
nv.$Jindo.compatible = function(){
    return false;
};

/**
	������Ʈ�� mixin�� �� ���.(source�� �Ӽ��� ������Ʈ�� �Ѿ.)
	
	@method mixin
	@static
	@param {Hash} oDestination
	@param {Hash} oSource
	@return {Hash} oNewObject
	@since 2.2.0
	@example
		var oDestination = {
			"foo" :1,
			"test" : function(){}
		};
		var oSource = {
			"bar" :1,
			"obj" : {},
			"test2" : function(){}
		};
		
		var  oNewObject = nv.$Jindo.mixin(oDestination,oSource);
		
		oNewObject == oDestination //false
		
		// oNewObject => {
		// "foo" :1,
		// "test" : function(){},
		//     
		// "bar" :1,
		// "obj" : {},
		// "test2" : function(){}
		// };
 */
nv.$Jindo.mixin = function(oDestination, oSource){
    g_checkVarType(arguments, {
        'obj' : [ 'oDestination:Hash+', 'oSource:Hash+' ]
    },"<static> $Jindo#mixin");

    var oReturn = {};

    for(var i in oDestination){
        oReturn[i] = oDestination[i];
    }

    for (i in oSource) if (oSource.hasOwnProperty(i)&&!nv.$Jindo.isHash(oSource[i])) {
        oReturn[i] = oSource[i];
    }
    return oReturn;
};

nv._p_._objToString = Object.prototype.toString;

nv.$Error = function(sMessage,sMethod){
    this.message = "\tmethod : "+sMethod+"\n\tmessage : "+sMessage;
    this.type = "Jindo Custom Error";
    this.toString = function(){
        return this.message+"\n\t"+this.type;
    };
};

nv.$Except = {
    CANNOT_USE_OPTION:"�ش� �ɼ��� ����� �� �����ϴ�.",
    CANNOT_USE_HEADER:"type�� jsonp �Ǵ� ����ũž ȯ�濡�� CORS ȣ��� XDomainRequest(IE8,9) ��ü�� ���Ǵ� ��� header�޼���� ����� �� �����ϴ�.",
    PARSE_ERROR:"�Ľ��� ������ �߻��߽��ϴ�.",
    NOT_FOUND_ARGUMENT:"�Ķ���Ͱ� �����ϴ�.",
    NOT_STANDARD_QUERY:"css�����Ͱ� ���������� �ʽ��ϴ�.",
    INVALID_DATE:"��¥ ������ �ƴմϴ�.",
    REQUIRE_AJAX:"�� �����ϴ�.",
    NOT_FOUND_ELEMENT:"������Ʈ�� �����ϴ�.",
    HAS_FUNCTION_FOR_GROUP:"�׷����� ������ �ʴ� ��� detach�� �Լ��� �־�� �մϴ�.",
    NONE_ELEMENT:"�� �ش��ϴ� ������Ʈ�� �����ϴ�.",
    NOT_SUPPORT_SELECTOR:"�� �������� �ʴ� selector�Դϴ�.",
	NOT_SUPPORT_CORS:"���� �������� CORS�� �������� �ʽ��ϴ�.",
    NOT_SUPPORT_METHOD:"desktop���� �������� �ʴ� �޼��� �Դϴ�.",
    JSON_MUST_HAVE_ARRAY_HASH:"get�޼���� jsonŸ���� hash�� arrayŸ�Ը� �����մϴ�.",
    MUST_APPEND_DOM : "document�� ���� ���� ������Ʈ�� ���� ������Ʈ�� ����� �� �����ϴ�.",
    NOT_USE_CSS : "�� css�� ��� �Ҽ� �����ϴ�.",
    NOT_WORK_DOMREADY : "domready�̺�Ʈ�� iframe�ȿ��� ����� �� �����ϴ�.",
    CANNOT_SET_OBJ_PROPERTY : "�Ӽ��� ������Ʈ�Դϴ�.\nŬ���� �Ӽ��� ������Ʈ�̸� ��� �ν��Ͻ��� �����ϱ� ������ �����մϴ�.",
    NOT_FOUND_HANDLEBARS : "{{not_found_handlebars}}",
    INVALID_MEDIA_QUERY : "{{invalid_media_query}}"
};

/**
 * @ignore
 */
nv._p_._toArray = function(aArray){
    return Array.prototype.slice.apply(aArray);
};

try{
    Array.prototype.slice.apply(document.documentElement.childNodes);
}catch(e){
    nv._p_._toArray = function(aArray){
        var returnArray = [];
        var leng = aArray.length;
        for ( var i = 0; i < leng; i++ ) {
            returnArray.push( aArray[i] );
        }
        return returnArray;
    };
}


/**
	�Ķ���Ͱ� Function���� Ȯ���ϴ� �Լ�.
	
	@method isFunction
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */

/**
	�Ķ���Ͱ� Array���� Ȯ���ϴ� �Լ�.
	
	@method isArray
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */

/**
	�Ķ���Ͱ� String���� Ȯ���ϴ� �Լ�.
	
	@method isString
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */

/**
	�Ķ���Ͱ� Numeric���� Ȯ���ϴ� �Լ�.
	
	@method isNumeric
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isNumeric = function(nNum){
    return !isNaN(parseFloat(nNum)) && !nv.$Jindo.isArray(nNum) &&isFinite( nNum );
};
/**
	�Ķ���Ͱ� Boolean���� Ȯ���ϴ� �Լ�.
	
	@method isBoolean
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
/**
	�Ķ���Ͱ� Date���� Ȯ���ϴ� �Լ�.
	
	@method isDate
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
/**
	�Ķ���Ͱ� Regexp���� Ȯ���ϴ� �Լ�.
	
	@method isRegexp
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
/**
	�Ķ���Ͱ� Element���� Ȯ���ϴ� �Լ�.
	
	@method isElement
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
/**
	�Ķ���Ͱ� Document���� Ȯ���ϴ� �Լ�.
	
	@method isDocument
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
(function(){
    var oType = {"Element" : 1,"Document" : 9};
    for(var i in oType){
        nv.$Jindo["is"+i] = (function(sType,nNodeNumber){
            return function(oObj){
                if(new RegExp(sType).test(nv._p_._objToString.call(oObj))){
                    return true;
                }else if(nv._p_._objToString.call(oObj) == "[object Object]"&&oObj !== null&&oObj !== undefined&&oObj.nodeType==nNodeNumber){
                    return true;
                }
                return false;
            };
        })(i,oType[i]);
    }
    var _$type = ["Function","Array","String","Boolean","Date","RegExp"];
    for(var i = 0, l = _$type.length; i < l ;i++){
        nv.$Jindo["is"+_$type[i]] = (function(type){
            return function(oObj){
                return nv._p_._objToString.call(oObj) == "[object "+type+"]";
            };
        })(_$type[i]);
    }
})();

/**
	�Ķ���Ͱ� Node���� Ȯ���ϴ� �Լ�.
	
	@method isNode
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isNode = function(eEle){
    try{
        return !!(eEle&&eEle.nodeType);
    }catch(e){
        return false;
    }
};

/**
	�Ķ���Ͱ� Hash���� Ȯ���ϴ� �Լ�.
	
	@method isHash
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isHash = function(oObj){
    return nv._p_._objToString.call(oObj) == "[object Object]"&&oObj !== null&&oObj !== undefined&&!!!oObj.nodeType&&!nv.$Jindo.isWindow(oObj);
};

/**
	�Ķ���Ͱ� Null���� Ȯ���ϴ� �Լ�.
	
	@method isNull
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isNull = function(oObj){
    return oObj === null;
};
/**
	�Ķ���Ͱ� Undefined���� Ȯ���ϴ� �Լ�.
	
	@method isUndefined
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isUndefined = function(oObj){
    return oObj === undefined;
};

/**
	�Ķ���Ͱ� Window���� Ȯ���ϴ� �Լ�.
	
	@method isWindow
	@static
	@param {Variant} oObj
	@return {Boolean} [true | false]
	@since 2.0.0
 */
nv.$Jindo.isWindow = function(oObj){
    return oObj && (oObj == window.top || oObj == oObj.window);
};
/**
 * @ignore
 */
nv.$Jindo.Break = function(){
    if (!(this instanceof arguments.callee)) throw new arguments.callee;
};
/**
 * @ignore
 */
nv.$Jindo.Continue = function(){
    if (!(this instanceof arguments.callee)) throw new arguments.callee;
};

/**
	�Լ� �Ķ���Ͱ� ���ϴ� ��Ģ�� �´��� �˻��Ѵ�.
	
	@method checkVarType
	@ignore
	@param {Array} aArgs �Ķ���� ���
	@param {Hash} oRules ��Ģ ���
	@param {String} sFuncName �����޽����� �����ٶ� ����� �Լ���
	@return {Object}
 */
nv.$Jindo._F = function(sKeyType) {
    return sKeyType;
};

nv.$Jindo._warn = function(sMessage){
    window.console && ( (console.warn && console.warn(sMessage), true) || (console.log && console.log(sMessage), true) );
};

nv.$Jindo._maxWarn = function(nCurrentLength, nMaxLength, sMessage) {
    if(nCurrentLength > nMaxLength) {
        nv.$Jindo._warn('�߰����� �Ķ���Ͱ� �ֽ��ϴ�. : '+sMessage);
    }
};

nv.$Jindo.checkVarType = function(aArgs, oRules, sFuncName) {
    var sFuncName = sFuncName || aArgs.callee.name || 'anonymous';
    var $Jindo = nv.$Jindo;
    var bCompat = $Jindo.compatible();

    var fpChecker = aArgs.callee['_checkVarType_' + bCompat];
    if (fpChecker) { return fpChecker(aArgs, oRules, sFuncName); }

    var aPrependCode = [];
    aPrependCode.push('var nArgsLen = aArgs.length;');
    aPrependCode.push('var $Jindo = '+nv._p_.nvName+'.$Jindo;');

    if(bCompat) {
        aPrependCode.push('var nMatchScore;');
        aPrependCode.push('var nMaxMatchScore = -1;');
        aPrependCode.push('var oFinalRet = null;');
    }

    var aBodyCode = [];
    var nMaxRuleLen = 0;

    for(var sType in oRules) if (oRules.hasOwnProperty(sType)) {
        nMaxRuleLen = Math.max(oRules[sType].length, nMaxRuleLen);
    }

    for(var sType in oRules) if (oRules.hasOwnProperty(sType)) {
        var aRule = oRules[sType];
        var nRuleLen = aRule.length;

        var aBodyPrependCode = [];
        var aBodyIfCode = [];
        var aBodyThenCode = [];

        if(!bCompat) {
            if (nRuleLen < nMaxRuleLen) { aBodyIfCode.push('nArgsLen === ' + nRuleLen); }
            else { aBodyIfCode.push('nArgsLen >= ' + nRuleLen); }
        }

        aBodyThenCode.push('var oRet = new $Jindo._varTypeRetObj();');

        var nTypeCount = nRuleLen;

        for (var i = 0; i < nRuleLen; ++i) {
            /^([^:]+):([^\+]*)(\+?)$/.test(aRule[i]);

            var sVarName = RegExp.$1,
                sVarType = RegExp.$2,
                bAutoCast = RegExp.$3 ? true : false;

            // if accept any type
            if (sVarType === 'Variant') {
                if (bCompat) {
                    aBodyIfCode.push(i + ' in aArgs');
                }

                aBodyThenCode.push('oRet["' + sVarName + '"] = aArgs[' + i + '];');
                nTypeCount--;

            // user defined type only
            } else if ($Jindo._varTypeList[sVarType]) {
                var vVar = 'tmp' + sVarType + '_' + i;

                aBodyPrependCode.push('var ' + vVar + ' = $Jindo._varTypeList.' + sVarType + '(aArgs[' + i + '], ' + bAutoCast + ');');
                aBodyIfCode.push(vVar + ' !== '+nv._p_.nvName+'.$Jindo.VARTYPE_NOT_MATCHED');
                aBodyThenCode.push('oRet["' + sVarName + '"] = ' + vVar + ';');

            // Jiindo wrapped type
            } else if (/^\$/.test(sVarType) && nv[sVarType]) {
                var sOR = '', sNativeVarType;

                if (bAutoCast) {
                    sNativeVarType = ({ $Fn : 'Function', $S : 'String', $A : 'Array', $H : 'Hash', $ElementList : 'Array' })[sVarType] || sVarType.replace(/^\$/, '');
                    if (nv.$Jindo['is' + sNativeVarType]) {
                        sOR = ' || $Jindo.is' + sNativeVarType + '(vNativeArg_' + i + ')';
                    }
                }

                aBodyIfCode.push('(aArgs[' + i + '] instanceof '+nv._p_.nvName+'.' + sVarType + sOR + ')');
                aBodyThenCode.push('oRet["' + sVarName + '"] = '+nv._p_.nvName+'.' + sVarType + '(aArgs[' + i + ']);');

            // any native type
            } else if (nv.$Jindo['is' + sVarType]) {
                var sOR = '', sWrapedVarType;

                if (bAutoCast) {
                    sWrapedVarType = ({ 'Function' : '$Fn', 'String' : '$S', 'Array' : '$A', 'Hash' : '$H' })[sVarType] || '$' + sVarType;
                    if (nv[sWrapedVarType]) {
                        sOR = ' || aArgs[' + i + '] instanceof '+nv._p_.nvName+'.' + sWrapedVarType;
                    }
                }

                aBodyIfCode.push('($Jindo.is' + sVarType + '(aArgs[' + i + '])' + sOR + ')');
                aBodyThenCode.push('oRet["' + sVarName + '"] = vNativeArg_' + i + ';');

            // type which doesn't exist
            } else {
                throw new Error('VarType(' + sVarType + ') Not Found');
            }
        }

        aBodyThenCode.push('oRet.__type = "' + sType + '";');

        if (bCompat) {
            aBodyThenCode.push('nMatchScore = ' + (nRuleLen * 1000 + nTypeCount * 10) + ' + (nArgsLen === ' + nRuleLen + ' ? 1 : 0);');
            aBodyThenCode.push('if (nMatchScore > nMaxMatchScore) {');
            aBodyThenCode.push('    nMaxMatchScore = nMatchScore;');
            aBodyThenCode.push('    oFinalRet = oRet;');
            aBodyThenCode.push('}');
        } else {
            aBodyThenCode.push('return oRet;');
        }

        aBodyCode.push(aBodyPrependCode.join('\n'));

        if (aBodyIfCode.length) { aBodyCode.push('if (' + aBodyIfCode.join(' && ') + ') {'); }
        aBodyCode.push(aBodyThenCode.join('\n'));
        if (aBodyIfCode.length) { aBodyCode.push('}'); }

    }

    aPrependCode.push(' $Jindo._maxWarn(nArgsLen,'+nMaxRuleLen+',"'+sFuncName+'");');

    for (var i = 0; i < nMaxRuleLen; ++i) {
        var sArg = 'aArgs[' + i + ']';
        aPrependCode.push([ 'var vNativeArg_', i, ' = ', sArg, ' && ', sArg, '.$value ? ', sArg, '.$value() : ', sArg + ';' ].join(''));
    }

    if (!bCompat) {
        aBodyCode.push('$Jindo.checkVarType._throwException(aArgs, oRules, sFuncName);');
    }

    aBodyCode.push('return oFinalRet;');

    // if (bCompat) { console.log(aPrependCode.join('\n') + aBodyCode.join('\n')); }
    aArgs.callee['_checkVarType_' + bCompat] = fpChecker = new Function('aArgs,oRules,sFuncName', aPrependCode.join('\n') + aBodyCode.join('\n'));
    return fpChecker(aArgs, oRules, sFuncName);

};

var g_checkVarType = nv.$Jindo.checkVarType;

// type check return type object
nv.$Jindo._varTypeRetObj = function() {};
nv.$Jindo._varTypeRetObj.prototype.toString = function(){ return this.__type; };

nv.$Jindo.checkVarType._throwException = function(aArgs, oRules, sFuncName) {
    var fpGetType = function(vArg) {

        for (var sKey in nv) if (nv.hasOwnProperty(sKey)) {
            var oConstructor = nv[sKey];
            if (typeof oConstructor !== 'function') { continue; }
            if (vArg instanceof oConstructor) { return sKey; }
        }

        var $Jindo = nv.$Jindo;

        for (var sKey in $Jindo) if ($Jindo.hasOwnProperty(sKey)) {
            if (!/^is(.+)$/.test(sKey)) { continue; }
            var sType = RegExp.$1;
            var fpMethod = $Jindo[sKey];
            if (fpMethod(vArg)) { return sType; }
        }

        return 'Unknown';

    };

    var fpErrorMessage = function(sUsed, aSuggs, sURL) {

        var aMsg = [ '�߸��� �Ķ�����Դϴ�.', '' ];

        if (sUsed) {
            aMsg.push('ȣ���� ���� :');
            aMsg.push('\t' + sUsed);
            aMsg.push('');
        }

        if (aSuggs.length) {
            aMsg.push('��� ������ ���� :');
            for (var i = 0, nLen = aSuggs.length; i < nLen; i++) {
                aMsg.push('\t' + aSuggs[i]);
            }
            aMsg.push('');
        }

        if (sURL) {
            aMsg.push('�Ŵ��� ������ :');
            aMsg.push('\t' + sURL);
            aMsg.push('');
        }

        aMsg.unshift();

        return aMsg.join('\n');

    };

    var aArgName = [];

    for (var i = 0, ic = aArgs.length; i < ic; ++i) {
        try { aArgName.push(fpGetType(aArgs[i])); }
        catch(e) { aArgName.push('Unknown'); }
    }

    var sUsed = sFuncName + '(' + aArgName.join(', ') + ')';
    var aSuggs = [];

    for (var sKey in oRules) if (oRules.hasOwnProperty(sKey)) {
        var aRule = oRules[sKey];
        aSuggs.push('' + sFuncName + '(' + aRule.join(', ').replace(/(^|,\s)[^:]+:/g, '$1') + ')');
    }

    var sURL;

    if (/(\$\w+)#(\w+)?/.test(sFuncName)) {
        sURL = 'http://jindo.dev.naver.com/docs/jindo/2.11.0/desktop/ko/classes/jindo.' + encodeURIComponent(RegExp.$1) + '.html' + "#method_"+RegExp.$2;
    }

    throw new TypeError(fpErrorMessage(sUsed, aSuggs, sURL));

};

var _getElementById = function(doc,id){
    // Modified because on IE6/7 can be selected elements using getElementById by name
    var docEle = doc.documentElement;
    var sCheckId = "nv"+ (new Date()).getTime();
    var eDiv = doc.createElement("div");
    eDiv.style.display =  "none";
    if(typeof MSApp != "undefined"){
        MSApp.execUnsafeLocalFunction(function(){
            eDiv.innerHTML = "<input type='hidden' name='"+sCheckId+"'/>";
        });
    }else{
        eDiv.innerHTML = "<input type='hidden' name='"+sCheckId+"'/>";
    }
    docEle.insertBefore( eDiv, docEle.firstChild );
    if(doc.getElementById(sCheckId)){
        _getElementById = function(doc,id){
            var eId = doc.getElementById(id);
            if(eId == null) return eId;
            if(eId.attributes['id'] && eId.attributes['id'].value == id){
                return eId;
            }
            var aEl = doc.all[id];
            for(var i=1; i<aEl.length; i++){
                if(aEl[i].attributes['id'] && aEl[i].attributes['id'].value == id){
                    return aEl[i];
                }
            }
        };
    }else{
        _getElementById = function(doc,id){
            return doc.getElementById(id);
        };
    }

    docEle.removeChild(eDiv);
    return _getElementById(doc,id);
};
/**
	checkVarType �� �����Ҷ� ����ϰ� �ִ� Ÿ���� ��´�.
	
	@method varType
	@ignore
	@param {String+} sTypeName Ÿ�� �̸�
	@return {Function} Ÿ���� �˻��ϴ� ��Ģ�� �����ϴ� �Լ�
 */
/**
	checkVarType �� �����Ҷ� ����� Ÿ���� �����Ѵ�.
	
	@method varType
	@ignore
	@syntax sTypeName, fpFunc
	@syntax oTypeLists
	@param {String+} sTypeName Ÿ�� �̸�
	@param {Function+} fpFunc Ÿ���� �˻��ϴ� ��Ģ�� �����ϴ� �Լ�
	@param {Hash+} oTypeLists Ÿ�� ��Ģ�� ���� ��ü, �� �ɼ��� ����ϸ� checkVarType �� �����Ҷ� ����� �������� Ÿ�Ե��� �ѹ��� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
 */
nv.$Jindo.varType = function() {

    var oArgs = this.checkVarType(arguments, {
        's4str' : [ 'sTypeName:String+', 'fpFunc:Function+' ],
        's4obj' : [ 'oTypeLists:Hash+' ],
        'g' : [ 'sTypeName:String+' ]
    });

    var sDenyTypeListComma = nv.$Jindo._denyTypeListComma;

    switch (oArgs+"") {
    case 's4str':
        var sTypeNameComma = ',' + oArgs.sTypeName.replace(/\+$/, '') + ',';
        if (sDenyTypeListComma.indexOf(sTypeNameComma) > -1) {
            throw new Error('Not allowed Variable Type');
        }

        this._varTypeList[oArgs.sTypeName] = oArgs.fpFunc;
        return this;

    case 's4obj':
        var oTypeLists = oArgs.oTypeLists, fpFunc;
        for (var sTypeName in oTypeLists) if (oTypeLists.hasOwnProperty(sTypeName)) {
            fpFunc = oTypeLists[sTypeName];
            arguments.callee.call(this, sTypeName, fpFunc);
        }
        return this;

    case 'g':
        return this._varTypeList[oArgs.sTypeName];
    }

};

/**
	varType �� ����� Ÿ�� üũ �Լ����� Ÿ���� ��Ī���� ������ �˸��� ������ ����Ѵ�.
	
	@constant VARTYPE_NOT_MATCHED
	@static
	@ignore
 */
nv.$Jindo.VARTYPE_NOT_MATCHED = {};

(function() {

    var oVarTypeList = nv.$Jindo._varTypeList = {};
    var cache = nv.$Jindo;
    var ___notMatched = cache.VARTYPE_NOT_MATCHED;
    oVarTypeList['Numeric'] = function(v) {
        if (cache.isNumeric(v)) { return v * 1; }
        return ___notMatched;
    };

    oVarTypeList['Hash'] = function(val, bAutoCast){
        if (bAutoCast && nv.$H && val instanceof nv.$H) {
            return val.$value();
        } else if (cache.isHash(val)) {
            return val;
        }
        return ___notMatched;
    };

    oVarTypeList['$Class'] = function(val, bAutoCast){
        if ((!cache.isFunction(val))||!val.extend) {
            return ___notMatched;
        }
        return val;
    };

    var aDenyTypeList = [];

    for (var sTypeName in cache) if (cache.hasOwnProperty(sTypeName)) {
        if (/^is(.+)$/.test(sTypeName)) { aDenyTypeList.push(RegExp.$1); }
    }

    cache._denyTypeListComma = aDenyTypeList.join(',');

    cache.varType("ArrayStyle",function(val, bAutoCast){
        if(!val) { return ___notMatched; }
        if (
            /(Arguments|NodeList|HTMLCollection|global|Window)/.test(nv._p_._objToString.call(val)) ||
            /Object/.test(nv._p_._objToString.call(val))&&cache.isNumeric(val.length)) {
            return nv._p_._toArray(val);
        }
        return ___notMatched;
    });

    cache.varType("Form",function(val, bAutoCast){
        if(!val) { return ___notMatched; }
        if(bAutoCast&&val.$value){
            val = val.$value();
        }
        if (val.tagName&&val.tagName.toUpperCase()=="FORM") {
            return val;
        }
        return ___notMatched;
    });
})();

nv._p_._createEle = function(sParentTag,sHTML,oDoc,bWantParent){
    //-@@_createEle.hidden-@@//
    var sId = 'R' + new Date().getTime() + parseInt(Math.random() * 100000,10);

    var oDummy = oDoc.createElement("div");
    switch (sParentTag) {
        case 'select':
        case 'table':
        case 'dl':
        case 'ul':
        case 'fieldset':
        case 'audio':
            oDummy.innerHTML = '<' + sParentTag + ' class="' + sId + '">' + sHTML + '</' + sParentTag + '>';
            break;
        case 'thead':
        case 'tbody':
        case 'col':
            oDummy.innerHTML = '<table><' + sParentTag + ' class="' + sId + '">' + sHTML + '</' + sParentTag + '></table>';
            break;
        case 'tr':
            oDummy.innerHTML = '<table><tbody><tr class="' + sId + '">' + sHTML + '</tr></tbody></table>';
            break;
        default:
            oDummy.innerHTML = '<div class="' + sId + '">' + sHTML + '</div>';
    }
    var oFound;
    for (oFound = oDummy.firstChild; oFound; oFound = oFound.firstChild){
        if (oFound.className==sId) break;
    }

    return bWantParent? oFound : oFound.childNodes;
};

//-!nv.$Jindo.default end!-//

/**
	Built-In Namespace _global_
	
	@class nv
	@static
 */
//-!nv.$ start!-//
/**
	$() �Լ��� Ư�� ��Ҹ� �����Ѵ�. "&lt;tagName&gt;" �� ���� ������ ���ڿ��� �Է��ϸ� tagName ��Ҹ� ������ ��ü�� �����Ѵ�.
	
	@method $
	@param {String+} elDomElement ������ DOM ���
	@return {Variant} ��Ҹ� �����ϰ� ��ü(Object) ���·� ��ȯ�Ѵ�.
	@throws {nv.$Except.NOT_FOUND_ARGUMENT} �Ķ���Ͱ� ���� ���.
	@remark Jindo 1.4.6 �������� ������ �Ķ���Ϳ� document ��Ҹ� ������ �� �ִ�.
	@example
		// tagName�� ���� ������ ���ڿ��� �̿��Ͽ� ��ü�� �����Ѵ�.
		var el = $("<DIV>");
		var els = $("<DIV id='div1'><SPAN>hello</SPAN></DIV>");
		
		// IE�� iframe�� �߰��� ������Ʈ�� �����Ϸ��� �� ���� document�� �ݵ�� �����ؾ� �Ѵ�.(1.4.6 ���� ����)
		var els = $("<div>" , iframe.contentWindow.document);
		// ���� ���� ��� div�±װ� iframe.contentWindow.document�������� ����.
 */
/**
	$() �Լ��� DOM���� Ư�� ��Ҹ� ������ �� �ְ� �����´�. ID�� ����Ͽ� DOM ���(Element)�� �����´�. �Ķ���͸� �� �� �̻� �����ϸ� DOM ��Ҹ� ���ҷ��ϴ� �迭�� ��ȯ�Ѵ�.
	
	@method $
	@param {String+} sID* ������ ù~N ��° DOM ����� ID �Ǵ� ������ DOM ���
	@return {Variant} ID ������ ������ DOM ���(Element) Ȥ�� DOM ��Ҹ� ���ҷ� ������ �迭(Array)�� ��ȯ�Ѵ�. ���� ID�� �ش��ϴ� ��Ұ� ������ null ���� ��ȯ�Ѵ�.
	@throws {nv.$Except.NOT_FOUND_ARGUMENT} �Ķ���Ͱ� ���� ���.
	@remark Jindo 1.4.6 �������� ������ �Ķ���Ϳ� document ��Ҹ� ������ �� �ִ�.
	@example
		// ID�� �̿��Ͽ� ��ü�� �����Ѵ�.
		<div id="div1"></div>
		
		var el = $("div1");
		
		// ID�� �̿��Ͽ� �������� ��ü�� �����Ѵ�.
		<div id="div1"></div>
		<div id="div2"></div>
		
		var els = $("div1","div2"); // [$("div1"),$("div2")]�� ���� ����� �����Ѵ�.
 */
nv.$ = function(sID/*, id1, id2*/) {
    //-@@$-@@//

    if(!arguments.length) throw new nv.$Error(nv.$Except.NOT_FOUND_ARGUMENT,"$");

    var ret = [], arg = arguments, nArgLeng = arg.length, lastArgument = arg[nArgLeng-1],doc = document,el  = null;
    var reg = /^<([a-z]+|h[1-5])>$/i;
    var reg2 = /^<([a-z]+|h[1-5])(\s+[^>]+)?>/i;
    if (nArgLeng > 1 && typeof lastArgument != "string" && lastArgument.body) {
        /*
         ������ ���ڰ� document�϶�.
         */
        arg = Array.prototype.slice.apply(arg,[0,nArgLeng-1]);
        doc = lastArgument;
    }

    for(var i=0; i < nArgLeng; i++) {
        el = arg[i] && arg[i].$value ? arg[i].$value() : arg[i];
        if (nv.$Jindo.isString(el)||nv.$Jindo.isNumeric(el)) {
            el += "";
            el = el.replace(/^\s+|\s+$/g, "");
            el = el.replace(/<!--(.|\n)*?-->/g, "");

            if (el.indexOf("<")>-1) {
                if(reg.test(el)) {
                    el = doc.createElement(RegExp.$1);
                } else if (reg2.test(el)) {
                    var p = { thead:'table', tbody:'table', tr:'tbody', td:'tr', dt:'dl', dd:'dl', li:'ul', legend:'fieldset',option:"select" ,source:"audio"};
                    var tag = RegExp.$1.toLowerCase();
                    var ele = nv._p_._createEle(p[tag],el,doc);

                    for(var i=0,leng = ele.length; i < leng ; i++) {
                        ret.push(ele[i]);
                    }

                    el = null;
                }
            }else {
                el = _getElementById(doc,el);
            }
        }
        if (el&&el.nodeType) ret[ret.length] = el;
    }
    return ret.length>1?ret:(ret[0] || null);
};

//-!nv.$ end!-//


//-!nv.$Class start!-//
/**
	nv.$Class() ��ü�� Jindo �����ӿ�ũ�� ����Ͽ� ��ü ���� ���α׷��� ������� ���ø����̼��� ������ �� �ֵ��� �����Ѵ�.
	
	@class nv.$Class
	@keyword class, Ŭ����
 */
/**
	Ŭ����(nv.$Class() ��ü)�� �����Ѵ�. �Ķ���ͷ� Ŭ����ȭ�� ��ü�� �Է��Ѵ�. �ش� ��ü�� $init �̸����� �޼��带 ����ϸ� Ŭ���� �ν��Ͻ��� �����ϴ� ������ �Լ��� ������ �� �ִ�. ����  Ű���带 ����ϸ� �ν��Ͻ��� �������� �ʾƵ� ����� �� �ִ� �޼��带 ����� �� �ִ�.
	
	@constructor
	@param {Hash+} oDef Ŭ������ �����ϴ� ��ü. Ŭ������ ������, �Ӽ�, �޼��� ���� �����Ѵ�.
	@return {nv.$Class} ������ Ŭ����(nv.$Class() ��ü).
	@example
		var CClass = $Class({
		    prop : null,
		    $init : function() {
		         this.prop = $Ajax();
		         ...
		    },
			$static : {
				static_method : function(){ return 1;}
			}
		});
		
		var c1 = new CClass();
		var c2 = new CClass();
		
		// c1�� c2�� ���� �ٸ� nv.$Ajax() ��ü�� ���� ������.
		CClass.static_method(); // 1
 */
/**
	$autoBind�Ӽ��� true�� ����ϸ� _�� �� �޼���� �ڵ����� bind�ȴ�.
	
	@property $autoBind
	@type boolean
	@example
		// $autoBind ����
		var OnAutoBind = $Class({
			$autoBind : true,
			num : 1,
			each : function(){
				$A([1,1]).forEach(this._check);	
			},
			_check : function(v){
				// this === OnScope �ν��Ͻ�
				value_of(v).should_be(this.num);
			}
		});
		
		new OnScope().each();
	@filter desktop
 */
/**
	$static���� ��ϵ� �޼���� $Class�� �ν��ϼ�ȭ ���� �ʾƵ� ����� �� �ִ�.
	
	@property $static
	@type Object
	@example
		// $static ����
		var Static = $Class({
			$static : {
				"do" : function(){
					console.log("static method");
				}
				
			}
		});
		
		Static.do();
		//static method
	@filter desktop
 */
nv.$Class = function(oDef) {
    //-@@$Class-@@//
    var oArgs = g_checkVarType(arguments, {
        '4obj' : [ 'oDef:Hash+' ]
    },"$Class");

    function typeClass() {
        var t = this;
        var a = [];

        var superFunc = function(m, superClass, func) {
            if(m!='constructor' && func.toString().indexOf("$super")>-1 ) {
                var funcArg = func.toString().replace(/function\s*\(([^\)]*)[\w\W]*/g,"$1").split(",");
                var funcStr = func.toString().replace(/function[^{]*{/,"").replace(/(\w|\.?)(this\.\$super|this)/g,function(m,m2,m3) {
                        if(!m2) { return m3+".$super"; }
                        return m;
                });
                funcStr = funcStr.substr(0,funcStr.length-1);
                func = superClass[m] = eval("false||function("+funcArg.join(",")+"){"+funcStr+"}");
            }

            return function() {
                var f = this.$this[m];
                var t = this.$this;
                var r = (t[m] = func).apply(t, arguments);
                t[m] = f;

                return r;
            };
        };

        while(t._$superClass !== undefined) {
            t.$super = new Object;
            t.$super.$this = this;

            for(var x in t._$superClass.prototype) {
                if (t._$superClass.prototype.hasOwnProperty(x)) {
                    if (this[x] === undefined && x !="$init") this[x] = t._$superClass.prototype[x];

                    if (x!='constructor' && x!='_$superClass' && typeof t._$superClass.prototype[x] == "function") {
                        t.$super[x] = superFunc(x, t._$superClass, t._$superClass.prototype[x]);
                    } else {
                        t.$super[x] = t._$superClass.prototype[x];
                    }
                }
            }

            if (typeof t.$super.$init == "function") a[a.length] = t;
            t = t.$super;
        }

        for(var i=a.length-1; i > -1; i--){
            a[i].$super.$init.apply(a[i].$super, arguments);
        }

        if(this.$autoBind) {
            for(var i in this){
                if(/^\_/.test(i) && typeof this[i] == "function") {
                    this[i] = nv.$Fn(this[i],this).bind();
                }
            }
        }

        if(typeof this.$init == "function") this.$init.apply(this,arguments);
    }

    if (oDef.$static !== undefined) {
        var i=0, x;
        for(x in oDef){
            if (oDef.hasOwnProperty(x)) {
                x=="$static"||i++;
            }
        }
        for(x in oDef.$static){
            if (oDef.$static.hasOwnProperty(x)) {
                typeClass[x] = oDef.$static[x];
            }
        }

        if (!i) return oDef.$static;
        delete oDef.$static;
    }

    typeClass.prototype = oDef;
    typeClass.prototype.constructor = typeClass;
    typeClass.prototype.kindOf = function(oClass){
        return nv._p_._kindOf(this.constructor.prototype, oClass.prototype);
    };
    typeClass.extend = nv.$Class.extend;

    return typeClass;
};

/**
	�ڽ��� � Ŭ������ �������� Ȯ���ϴ� �޼���.
	
	@method kindOf
	@param {nv.$Class} oClass Ȯ���� Ŭ����(nv.$Class() ��ü)
	@return {Boolean} true | false
	@since 2.0.0
	@example
		var Parent = $Class ({});
		var Parent2 = $Class ({});
		var Child = $Class ({}).extend(Parent);
		
		var child = new Child();
		child.kindOf(Parent);// true
		child.kindOf(Parent2);// false
 */
nv._p_._kindOf = function(oThis, oClass){
    if(oThis != oClass){
        if(oThis._$superClass) {
            return nv._p_._kindOf(oThis._$superClass.prototype,oClass);
        } else {
            return false;
        }
    } else {
        return true;
    }
};
 /**
	extend() �޼���� Ư�� Ŭ����(nv.$Class() ��ü)�� ����Ѵ�. ����� �θ� Ŭ����(Super Class)�� �����Ѵ�.
	
	@method extend
	@param {nv.$Class} superClass ����� �θ� Ŭ����(nv.$Class() ��ü).
	@return {this} ��ӵ� �ν��Ͻ� �ڽ�
	@example
		var ClassExt = $Class(classDefinition);
		ClassExt.extend(superClass);
		// ClassExt�� SuperClass�� ��ӹ޴´�.
 */
nv.$Class.extend = function(superClass) {
    var oArgs = g_checkVarType(arguments, {
        '4obj' : [ 'oDef:$Class' ]
    },"<static> $Class#extend");

    this.prototype._$superClass = superClass;


    // inherit static methods of parent
    var superProto = superClass.prototype;
    for(var prop in superProto){
        if(nv.$Jindo.isHash(superProto[prop])) nv.$Jindo._warn(nv.$Except.CANNOT_SET_OBJ_PROPERTY);
    }
    for(var x in superClass) {
        if (superClass.hasOwnProperty(x)) {
            if (x == "prototype") continue;
            this[x] = superClass[x];
        }
    }
    return this;
};
/**
	$super �Ӽ��� �θ� Ŭ������ �޼��忡 ������ �� ����Ѵ�. ���� Ŭ������ this.$super.method �� ���� Ŭ������ �޼��忡 ������ �� ������, this.$super.$super.method �� ���� �� �ܰ� �̻��� ���� Ŭ������ ������ �� ����. ���� �θ� Ŭ������ �ڽ�Ŭ������ ���� �̸��� �޼��带 ������ ���� �� �ڽ�Ŭ�������� $super�� ���� �̸��� �޼��带 ȣ���ϸ�, �θ� Ŭ������ �޼��带 ȣ���Ѵ�.
	
	@property $super
	@type $Class
	@example
		var Parent = $Class ({
			a: 100,
			b: 200,
			c: 300,
			sum2: function () {
				var init = this.sum();
				return init;
			},
			sum: function () {
				return this.a + this.b
			}
		});
	
		var Child = $Class ({
			a: 10,
			b: 20,
			sum2 : function () {
				var init = this.sum();
				return init;
			},
			sum: function () {
				return this.b;
			}
		}).extend (Parent);
	
		var oChild = new Child();
		var oParent = new Parent();
	
		oChild.sum();           // 20
		oChild.sum2();          // 20
		oChild.$super.sum();    // 30 -> �θ� Ŭ������ 100(a)�� 200(b)��� �ڽ� Ŭ������ 10(a)�� 20(b)�� ���Ѵ�.
		oChild.$super.sum2();   // 20 -> �θ� Ŭ������ sum2 �޼��忡�� �θ� Ŭ������ sum()�� �ƴ� �ڽ� Ŭ������ sum()�� ȣ���Ѵ�.
*/
//-!nv.$Class end!-//

/**
    nv�� ������ Ÿ�� �Ӽ�

    nv.VERSION; // �������� ���ڿ� - ex. "2.9.2"
    nv.TYPE;    // ���� Ÿ�� ���ڿ� (desktop|mobile) - ex. "desktop"
*/
nv.VERSION = "2.11.0";
nv.TYPE = "desktop";

/**
 	@fileOverview CSS �����͸� ����� ������Ʈ ���� ����
	@name cssquery.js
	@author  AjaxUI lab
 */
//-!nv.cssquery start(nv.$Element)!-//
/**
 	Built-In Namespace _global_
	
	@class nv
	@static
 */
/**
 	$$() �Լ�(cssquery)�� CSS ������(CSS Selector)�� ����Ͽ� ��ü�� Ž���Ѵ�. $$() �Լ� ��� cssquery() �Լ��� ����ص� �ȴ�.

	@method $$
	@syntax sSelector, elBaseElement
	@syntax sSelector, sBaseElement
	@param {String+} sSelector CSS ������.
	@param {Element+} [elBaseElement] Ž�� ����� �Ǵ� DOM ���. ������ ����� ���� ��忡���� ��ü�� Ž���Ѵ�.
	@param {String+} sBaseElement Ž�� ����� �Ǵ� DOM ����� ID ���ڿ�. ������ ����� ���� ��忡���� ��ü�� Ž���Ѵ�.
	@return {Array} ���ǿ� �ش��ϴ� ��Ҹ� �迭 ���·� ��ȯ�Ѵ�.
	@remark CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS Level3 ������ �ִ� ������ �����Ѵ�. �������� ���Ͽ� ���� ������ ���� ǥ�� See Also �׸��� �����Ѵ�.<br>
		<h5>���, ID, Ŭ���� ������</h5>
		<table class="tbl_board">
			<caption class="hide">���, ID, Ŭ���� ������</caption>
			<thead>
				<tr>
					<th scope="col" style="width:20%">����</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">*</td>
					<td class="txt">��� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("*");
	// ������ ��� ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">HTML Tagname</td>
					<td class="txt">������ HTML �±� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("div");
	// ������ ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">#id</td>
					<td class="txt">ID�� ������ ���.
<pre class="code "><code class="prettyprint linenums">
	$$("#application");
	// ID�� application�� ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">.classname</td>
					<td class="txt">Ŭ������ ������ ���.
<pre class="code "><code class="prettyprint linenums">
	$$(".img");
	// Ŭ������ img�� ���.
</code></pre>
					</td>
				</tr>
			</tbody>
		</table>
		<h5>�Ӽ� ������</h5>
		<table class="tbl_board">
			<caption class="hide">�Ӽ� ������</caption>
			<thead>
				<tr>
					<th scope="col" style="width:20%">����</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">[type]</td>
					<td class="txt">������ �Ӽ��� ���� �ִ� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("input[type]");
	// type �Ӽ��� ���� &lt;input&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type=value]</td>
					<td class="txt">�Ӽ��� ���� ��ġ�ϴ� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("input[type=text]");
	// type �Ӽ� ���� text�� &lt;input&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type^=value]</td>
					<td class="txt">�Ӽ��� ���� Ư�� ������ �����ϴ� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("input[type^=hid]");
	//type �Ӽ� ���� hid�� �����ϴ� &lt;input&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type$=value]</td>
					<td class="txt">�Ӽ��� ���� Ư�� ������ ������ ���.
<pre class="code "><code class="prettyprint linenums">
	$$("input[type$=en]");
	//type �Ӽ� ���� en���� ������ &lt;input&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type~=value]</td>
					<td class="txt">�Ӽ� ���� �������� ���е� ���� ���� ���� �����ϴ� ���, ������ �� �� �Ѱ��� ���� ���� ���.
<pre class="code "><code class="prettyprint linenums">
	&lt;img src="..." alt="welcome to naver"&gt;
	$$("img[alt~=welcome]"); // ����.
	$$("img[alt~=naver]"); // ����.
	$$("img[alt~=wel]"); // ����.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type*=value]</td>
					<td class="txt">�Ӽ� �� �߿� ��ġ�ϴ� ���� �ִ� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("img[alt*=come]"); // ����.
	$$("img[alt*=nav]"); // ����.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[type!=value]</td>
					<td class="txt">���� ������ ���� ��ġ���� �ʴ� ���.
<pre class="code "><code class="prettyprint linenums">
	$$("input[type!=text]");
	// type �Ӽ� ���� text�� �ƴ� ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">[@type]</td>
					<td class="txt">cssquery �������� ����ϴ� �����ڷμ� ����� �Ӽ��� �ƴ� ����� ��Ÿ�� �Ӽ��� ����Ѵ�. CSS �Ӽ� �������� Ư���� ��� ������ ����� �� �ִ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div[@display=block]");
	// &lt;div&gt; ��� �߿� display ��Ÿ�� �Ӽ��� ���� block�� ���.
</code></pre>
					</td>
				</tr>
			</tbody>
		</table>
		<h5>���� Ŭ���� ������</h5>
		<table class="tbl_board">
			<caption class="hide">���� Ŭ���� ������</caption>
			<thead>
				<tr>
					<th scope="col" style="width:20%">����</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">:nth-child(n)</td>
					<td class="txt">n��° �ڽ����� ���η� �ش� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div:nth-child(2)");
	// �� ��° �ڽ� ����� &lt;div&gt; ���.
	
	$$("div:nth-child(2n)");
	$$("div:nth-child(even)");
	// ¦�� ��° �ڽ� ����� ��� &lt;div&gt; ���.
	
	$$("div:nth-child(2n+1)");
	$$("div:nth-child(odd)");
	// Ȧ�� ��° �ڽ� ����� ��� &lt;div&gt; ���.
	
	$$("div:nth-child(4n)");
	// 4�� ��� ��° �ڽ� ����� ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">:nth-last-child(n)</td>
					<td class="txt">nth-child�� �����ϳ�, �ڿ������� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div:nth-last-child(2)");
	// �ڿ��� �� ��° �ڽ� ����� ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">:last-child</td>
					<td class="txt">������ �ڽ����� ���η� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div:last-child");
	// ������ �ڽ� ����� ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">:nth-of-type(n)</td>
					<td class="txt">n��°�� �߰ߵ� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	&lt;div&gt;
		&lt;p&gt;1&lt;/p&gt;
		&lt;span&gt;2&lt;/span&gt;
		&lt;span&gt;3&lt;/span&gt;
	&lt;/div&gt;
</code></pre>
						���� ���� DOM�� ���� ��, $$("span:nth-child(1)")�� &lt;span&gt; ��Ұ� firstChild�� ��Ҵ� ���� ������ ��� ���� ��ȯ���� �ʴ´� ������ $$("span:nth-of-type(1)")�� &lt;span&gt; ��� �߿��� ù ��° &lt;span&gt; ����� &lt;span&gt;2&lt;/span&gt;�� ������ �ȴ�.<br>nth-child�� ���������� ¦��/Ȧ�� ���� ������ ����� �� �ִ�.
					</td>
				</tr>
				<tr>
					<td class="txt bold">:first-of-type</td>
					<td class="txt">���� �±� �̸��� ���� ���� ��� �߿��� ù ��° ��Ҹ� �����Ѵ�.<br>nth-of-type(1)�� ���� ��� ���� ��ȯ�Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">:nth-last-of-type</td>
					<td class="txt">nth-of-type�� �����ϳ�, �ڿ������� ��Ҹ� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">:last-of-type</td>
					<td class="txt">���� �±� �̸��� ���� ���� ��� �߿��� ������ ��Ҹ� �����Ѵ�.<br>nth-last-of-type(1)�� ���� ��� ���� ��ȯ�Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">:contains</td>
					<td class="txt">�ؽ�Ʈ ��忡 Ư�� ���ڿ��� �����ϰ� �ִ��� ���η� �ش� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("span:contains(Jindo)");
	// "Jindo" ���ڿ��� �����ϰ� �ִ� &lt;span&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">:only-child</td>
					<td class="txt">������ ���� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	&lt;div&gt;
		&lt;p&gt;1&lt;/p&gt;
		&lt;span&gt;2&lt;/span&gt;
		&lt;span&gt;3&lt;/span&gt;
	&lt;/div&gt;
</code></pre>
						���� DOM���� $$("div:only-child")�� ��ȯ ���� �ְ�, $$("p:only-child") �Ǵ� $$("span:only-child")�� ��ȯ ���� ����. ��, ���� ��尡 ���� &lt;div&gt; ��Ҹ� ���õȴ�.
					</td>
				</tr>
				<tr>
					<td class="txt bold">:empty</td>
					<td class="txt">����ִ� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("span:empty");
	// �ؽ�Ʈ ��� �Ǵ� ���� ��尡 ���� &lt;span&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">:not</td>
					<td class="txt">�������� ���ǰ� �ݴ��� ��Ҹ� �����Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div:not(.img)");
	// img Ŭ������ ���� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
			</tbody>
		</table>
		<h5>�޺������ ������</h5>
		<table class="tbl_board">
			<caption class="hide">�޺������ ������</caption>
			<thead>
				<tr>
					<th scope="col" style="width:20%">����</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">���� (space)</td>
					<td class="txt">������ ��� ��Ҹ� �ǹ��Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("body div");
	// &lt;body&gt; ��� ������ ���� ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">&gt;</td>
					<td class="txt">�ڽ� ��忡 ���ϴ� ��� ��Ҹ� �ǹ��Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div &gt; span");
	// &lt;div&gt; ����� �ڽ� ��� �� ��� &lt;span&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">+</td>
					<td class="txt">������ ����� �ٷ� ���� ���� ��忡 ���ϴ� ��� ��Ҹ� �ǹ��Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div + p");
	// &lt;div&gt; ����� nextSibling�� �ش��ϴ� ��� &lt;p&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">~</td>
					<td class="txt">+ ���ϰ� �����ϳ�, �ٷ� ���� ���� ���Ӹ� �ƴ϶� ������ ��� ���Ŀ� ���ϴ� ��� ��Ҹ� �ǹ��Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("div ~ p");
	// &lt;div&gt; ��� ������ ���� ��忡 ���ϴ� ��� &lt;p&gt; ���.
</code></pre>
					</td>
				</tr>
				<tr>
					<td class="txt bold">!</td>
					<td class="txt">cssquery ��������, �޺�������� �ݴ� �������� Ž���� ������ ��Ҹ� �˻��Ѵ�.
<pre class="code "><code class="prettyprint linenums">
	$$("span ! div");
	// &lt;span&gt; ����� ������ �ִ� ��� &lt;div&gt; ���.
</code></pre>
					</td>
				</tr>
			</tbody>
		</table>
	@see nv.$Document#queryAll
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
	@history 2.4.0 Support mobile���� JindoJS���� ! �޺������ ����(!, !>, !~, !+)
	@example
		// �������� IMG �±׸� ã�´�.
		var imgs = $$('IMG');
		
		// div ��� �������� IMG �±׸� ã�´�.
		var imgsInDiv = $$('IMG', $('div'));
		
		// �������� IMG �±� �� ���� ù ��Ҹ� ã�´�.
		var firstImg = $$.getSingle('IMG');
 */
nv.$$ = nv.cssquery = (function() {
    /*
     querySelector ����.
     */
    var sVersion = '3.0';
    
    var debugOption = { repeat : 1 };
    
    /*
     ���� ó���� ���� ��帶�� ����Ű �� ����
     */
    var UID = 1;
    
    var cost = 0;
    var validUID = {};
    
    var bSupportByClassName = document.getElementsByClassName ? true : false;
    var safeHTML = false;
    
    var getUID4HTML = function(oEl) {
        
        var nUID = safeHTML ? (oEl._cssquery_UID && oEl._cssquery_UID[0]) : oEl._cssquery_UID;
        if (nUID && validUID[nUID] == oEl) return nUID;
        
        nUID = UID++;
        oEl._cssquery_UID = safeHTML ? [ nUID ] : nUID;
        
        validUID[nUID] = oEl;
        return nUID;

    };
    function GEBID(oBase,sId,oDoc) {
        if(oBase.nodeType === 9 || oBase.parentNode && oBase.parentNode.tagName) {
            return _getElementById(oDoc,sId);
        } else {
            var aEle = oBase.getElementsByTagName("*");

            for(var i = 0,l = aEle.length; i < l; i++){
                if(aEle[i].id === sId) {
                    return aEle[i];
                }
            }
        }
    }
    var getUID4XML = function(oEl) {
        var oAttr = oEl.getAttribute('_cssquery_UID');
        var nUID = safeHTML ? (oAttr && oAttr[0]) : oAttr;
        
        if (!nUID) {
            nUID = UID++;
            oEl.setAttribute('_cssquery_UID', safeHTML ? [ nUID ] : nUID);
        }
        
        return nUID;
        
    };
    
    var getUID = getUID4HTML;
    
    var uniqid = function(sPrefix) {
        return (sPrefix || '') + new Date().getTime() + parseInt(Math.random() * 100000000,10);
    };
    
    function getElementsByClass(searchClass,node,tag) {
        var classElements = [];

        if(node == null) node = document;
        if(tag == null) tag = '*';

        var els = node.getElementsByTagName(tag);
        var elsLen = els.length;
        var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");

        for(var i=0,j=0; i < elsLen; i++) {
            if(pattern.test(els[i].className)) {
                classElements[j] = els[i];
                j++;
            }
        }
        return classElements;
    }

    var getChilds_dontShrink = function(oEl, sTagName, sClassName) {
        if (bSupportByClassName && sClassName) {
            if(oEl.getElementsByClassName)
                return oEl.getElementsByClassName(sClassName);
            if(oEl.querySelectorAll)
                return oEl.querySelectorAll(sClassName);
            return getElementsByClass(sClassName, oEl, sTagName);
        }else if (sTagName == '*') {
            return oEl.all || oEl.getElementsByTagName(sTagName);
        }
        return oEl.getElementsByTagName(sTagName);
    };

    var clearKeys = function() {
         backupKeys._keys = {};
    };
    
    var oDocument_dontShrink = document;
    
    var bXMLDocument = false;
    
    /*
     ����ǥ, [] �� �Ľ̿� ������ �� �� �ִ� �κ� replace ���ѳ���
     */
    var backupKeys = function(sQuery) {
        
        var oKeys = backupKeys._keys;
        
        /*
         ���� ����ǥ �Ⱦ��
         */
        sQuery = sQuery.replace(/'(\\'|[^'])*'/g, function(sAll) {
            var uid = uniqid('QUOT');
            oKeys[uid] = sAll;
            return uid;
        });
        
        /*
         ū ����ǥ �Ⱦ��
         */
        sQuery = sQuery.replace(/"(\\"|[^"])*"/g, function(sAll) {
            var uid = uniqid('QUOT');
            oKeys[uid] = sAll;
            return uid;
        });
        
        /*
         [ ] ���� �Ⱦ��
         */
        sQuery = sQuery.replace(/\[(.*?)\]/g, function(sAll, sBody) {
            if (sBody.indexOf('ATTR') == 0) return sAll;
            var uid = '[' + uniqid('ATTR') + ']';
            oKeys[uid] = sAll;
            return uid;
        });
    
        /*
        ( ) ���� �Ⱦ��
         */
        var bChanged;
        
        do {
            
            bChanged = false;
        
            sQuery = sQuery.replace(/\(((\\\)|[^)|^(])*)\)/g, function(sAll, sBody) {
                if (sBody.indexOf('BRCE') == 0) return sAll;
                var uid = '_' + uniqid('BRCE');
                oKeys[uid] = sAll;
                bChanged = true;
                return uid;
            });
        
        } while(bChanged);
    
        return sQuery;
        
    };
    
    /*
     replace ���ѳ��� �κ� �����ϱ�
     */
    var restoreKeys = function(sQuery, bOnlyAttrBrace) {
        
        var oKeys = backupKeys._keys;
    
        var bChanged;
        var rRegex = bOnlyAttrBrace ? /(\[ATTR[0-9]+\])/g : /(QUOT[0-9]+|\[ATTR[0-9]+\])/g;
        
        do {
            
            bChanged = false;
    
            sQuery = sQuery.replace(rRegex, function(sKey) {
                
                if (oKeys[sKey]) {
                    bChanged = true;
                    return oKeys[sKey];
                }
                
                return sKey;
    
            });
        
        } while(bChanged);
        
        /*
        ( ) �� �Ѳ�Ǯ�� ���ܳ���
         */
        sQuery = sQuery.replace(/_BRCE[0-9]+/g, function(sKey) {
            return oKeys[sKey] ? oKeys[sKey] : sKey;
        });
        
        return sQuery;
        
    };
    
    /*
     replace ���ѳ��� ���ڿ����� Quot �� �����ϰ� ����
     */
    var restoreString = function(sKey) {
        
        var oKeys = backupKeys._keys;
        var sOrg = oKeys[sKey];
        
        if (!sOrg) return sKey;
        return eval(sOrg);
        
    };
    
    var wrapQuot = function(sStr) {
        return '"' + sStr.replace(/"/g, '\\"') + '"';
    };
    
    var getStyleKey = function(sKey) {

        if (/^@/.test(sKey)) return sKey.substr(1);
        return null;
        
    };
    
    var getCSS = function(oEl, sKey) {
        
        if (oEl.currentStyle) {
            
            if (sKey == "float") sKey = "styleFloat";
            return oEl.currentStyle[sKey] || oEl.style[sKey];
            
        } else if (window.getComputedStyle) {
            
            return oDocument_dontShrink.defaultView.getComputedStyle(oEl, null).getPropertyValue(sKey.replace(/([A-Z])/g,"-$1").toLowerCase()) || oEl.style[sKey];
            
        }

        if (sKey == "float" && nv._p_._JINDO_IS_IE) sKey = "styleFloat";
        return oEl.style[sKey];
        
    };

    var oCamels = {
        'accesskey' : 'accessKey',
        'cellspacing' : 'cellSpacing',
        'cellpadding' : 'cellPadding',
        'class' : 'className',
        'colspan' : 'colSpan',
        'for' : 'htmlFor',
        'maxlength' : 'maxLength',
        'readonly' : 'readOnly',
        'rowspan' : 'rowSpan',
        'tabindex' : 'tabIndex',
        'valign' : 'vAlign'
    };

    var getDefineCode = function(sKey) {
        var sVal;
        var sStyleKey;

        if (bXMLDocument) {
            
            sVal = 'oEl.getAttribute("' + sKey + '",2)';
        
        } else {
        
            if (sStyleKey = getStyleKey(sKey)) {
                
                sKey = '$$' + sStyleKey;
                sVal = 'getCSS(oEl, "' + sStyleKey + '")';
                
            } else {
                
                switch (sKey) {
                case 'checked':
                    sVal = 'oEl.checked + ""';
                    break;
                    
                case 'disabled':
                    sVal = 'oEl.disabled + ""';
                    break;
                    
                case 'enabled':
                    sVal = '!oEl.disabled + ""';
                    break;
                    
                case 'readonly':
                    sVal = 'oEl.readOnly + ""';
                    break;
                    
                case 'selected':
                    sVal = 'oEl.selected + ""';
                    break;
                    
                default:
                    if (oCamels[sKey]) {
                        sVal = 'oEl.' + oCamels[sKey];
                    } else {
                        sVal = 'oEl.getAttribute("' + sKey + '",2)';
                    } 
                }
                
            }
            
        }
            
        return '_' + sKey.replace(/\-/g,"_") + ' = ' + sVal;
    };
    
    var getReturnCode = function(oExpr) {
        
        var sStyleKey = getStyleKey(oExpr.key);
        
        var sVar = '_' + (sStyleKey ? '$$' + sStyleKey : oExpr.key);
        sVar = sVar.replace(/\-/g,"_");
        var sVal = oExpr.val ? wrapQuot(oExpr.val) : '';
        
        switch (oExpr.op) {
        case '~=':
            return '(' + sVar + ' && (" " + ' + sVar + ' + " ").indexOf(" " + ' + sVal + ' + " ") > -1)';
        case '^=':
            return '(' + sVar + ' && ' + sVar + '.indexOf(' + sVal + ') == 0)';
        case '$=':
            return '(' + sVar + ' && ' + sVar + '.substr(' + sVar + '.length - ' + oExpr.val.length + ') == ' + sVal + ')';
        case '*=':
            return '(' + sVar + ' && ' + sVar + '.indexOf(' + sVal + ') > -1)';
        case '!=':
            return '(' + sVar + ' != ' + sVal + ')';
        case '=':
            return '(' + sVar + ' == ' + sVal + ')';
        }
    
        return '(' + sVar + ')';
        
    };
    
    var getNodeIndex = function(oEl) {
        var nUID = getUID(oEl);
        var nIndex = oNodeIndexes[nUID] || 0;
        
        /*
         ��� �ε����� ���� �� ������
         */
        if (nIndex == 0) {

            for (var oSib = (oEl.parentNode || oEl._IE5_parentNode).firstChild; oSib; oSib = oSib.nextSibling) {
                
                if (oSib.nodeType != 1){ 
                    continue;
                }
                nIndex++;

                setNodeIndex(oSib, nIndex);
                
            }
                        
            nIndex = oNodeIndexes[nUID];
            
        }
                
        return nIndex;
                
    };
    
    /*
     ���° �ڽ����� �����ϴ� �κ�
     */
    var oNodeIndexes = {};

    var setNodeIndex = function(oEl, nIndex) {
        var nUID = getUID(oEl);
        oNodeIndexes[nUID] = nIndex;
    };
    
    var unsetNodeIndexes = function() {
        setTimeout(function() { oNodeIndexes = {}; }, 0);
    };
    
    /*
     ���� Ŭ����
     */
    var oPseudoes_dontShrink = {
    
        'contains' : function(oEl, sOption) {
            return (oEl.innerText || oEl.textContent || '').indexOf(sOption) > -1;
        },
        
        'last-child' : function(oEl, sOption) {
            for (oEl = oEl.nextSibling; oEl; oEl = oEl.nextSibling){
                if (oEl.nodeType == 1)
                    return false;
            }
                
            
            return true;
        },
        
        'first-child' : function(oEl, sOption) {
            for (oEl = oEl.previousSibling; oEl; oEl = oEl.previousSibling){
                if (oEl.nodeType == 1)
                    return false;
            }
                
                    
            return true;
        },
        
        'only-child' : function(oEl, sOption) {
            var nChild = 0;
            
            for (var oChild = (oEl.parentNode || oEl._IE5_parentNode).firstChild; oChild; oChild = oChild.nextSibling) {
                if (oChild.nodeType == 1) nChild++;
                if (nChild > 1) return false;
            }
            
            return nChild ? true : false;
        },

        'empty' : function(oEl, _) {
            return oEl.firstChild ? false : true;
        },
        
        'nth-child' : function(oEl, nMul, nAdd) {
            var nIndex = getNodeIndex(oEl);
            return nIndex % nMul == nAdd;
        },
        
        'nth-last-child' : function(oEl, nMul, nAdd) {
            var oLast = (oEl.parentNode || oEl._IE5_parentNode).lastChild;
            for (; oLast; oLast = oLast.previousSibling){
                if (oLast.nodeType == 1) break;
            }
                
                
            var nTotal = getNodeIndex(oLast);
            var nIndex = getNodeIndex(oEl);
            
            var nLastIndex = nTotal - nIndex + 1;
            return nLastIndex % nMul == nAdd;
        },
        'checked' : function(oEl){
            return !!oEl.checked;
        },
        'selected' : function(oEl){
            return !!oEl.selected;
        },
        'enabled' : function(oEl){
            return !oEl.disabled;
        },
        'disabled' : function(oEl){
            return !!oEl.disabled;
        }
    };
    
    /*
     ���� part �� body ���� expression �̾Ƴ�
     */
    var getExpression = function(sBody) {

        var oRet = { defines : '', returns : 'true' };
        
        var sBody = restoreKeys(sBody, true);
    
        var aExprs = [];
        var aDefineCode = [], aReturnCode = [];
        var sId, sTagName;
        
        /*
         ����Ŭ���� ���� ����
         */
        var sBody = sBody.replace(/:([\w-]+)(\(([^)]*)\))?/g, function(_1, sType, _2, sOption) {
            switch (sType) {
                case 'not':
                    /*
                     ��ȣ �ȿ� �ִ°� ����Ľ��ϱ�
                     */
                    var oInner = getExpression(sOption);

                    var sFuncDefines = oInner.defines;
                    var sFuncReturns = oInner.returnsID + oInner.returnsTAG + oInner.returns;

                    aReturnCode.push('!(function() { ' + sFuncDefines + ' return ' + sFuncReturns + ' })()');
                    break;

                case 'nth-child':
                case 'nth-last-child':
                    sOption =  restoreString(sOption);

                    if (sOption == 'even'){
                        sOption = '2n';
                    }else if (sOption == 'odd') {
                        sOption = '2n+1';
                    }

                    var nMul, nAdd;
                    var matchstr = sOption.match(/([0-9]*)n([+-][0-9]+)*/);
                    if (matchstr) {
                        nMul = matchstr[1] || 1;
                        nAdd = matchstr[2] || 0;
                    } else {
                        nMul = Infinity;
                        nAdd = parseInt(sOption,10);
                    }
                    aReturnCode.push('oPseudoes_dontShrink[' + wrapQuot(sType) + '](oEl, ' + nMul + ', ' + nAdd + ')');
                    break;

                case 'first-of-type':
                case 'last-of-type':
                    sType = (sType == 'first-of-type' ? 'nth-of-type' : 'nth-last-of-type');
                    sOption = 1;
                    // 'break' statement was intentionally omitted.
                case 'nth-of-type':
                case 'nth-last-of-type':
                    sOption =  restoreString(sOption);

                    if (sOption == 'even') {
                        sOption = '2n';
                    }else if (sOption == 'odd'){
                        sOption = '2n+1';
                    }

                    var nMul, nAdd;

                    if (/([0-9]*)n([+-][0-9]+)*/.test(sOption)) {
                        nMul = parseInt(RegExp.$1,10) || 1;
                        nAdd = parseInt(RegExp.$2,20) || 0;
                    } else {
                        nMul = Infinity;
                        nAdd = parseInt(sOption,10);
                    }

                    oRet.nth = [ nMul, nAdd, sType ];
                    break;

                default:
                    sOption = sOption ? restoreString(sOption) : '';
                    aReturnCode.push('oPseudoes_dontShrink[' + wrapQuot(sType) + '](oEl, ' + wrapQuot(sOption) + ')');
            }
            
            return '';
        });
        
        /*
         [key=value] ���� ���� ����
         */
        var sBody = sBody.replace(/\[(@?[\w-]+)(([!^~$*]?=)([^\]]*))?\]/g, function(_1, sKey, _2, sOp, sVal) {
            sKey = restoreString(sKey);
            sVal = restoreString(sVal);
            
            if (sKey == 'checked' || sKey == 'disabled' || sKey == 'enabled' || sKey == 'readonly' || sKey == 'selected') {
                
                if (!sVal) {
                    sOp = '=';
                    sVal = 'true';
                }
                
            }
            aExprs.push({ key : sKey, op : sOp, val : sVal });
            return '';
    
        });
        
        var sClassName = null;
    
        /*
         Ŭ���� ���� ����
         */
        var sBody = sBody.replace(/\.([\w-]+)/g, function(_, sClass) { 
            aExprs.push({ key : 'class', op : '~=', val : sClass });
            if (!sClassName) sClassName = sClass;
            return '';
        });
        
        /*
         id ���� ����
         */
        var sBody = sBody.replace(/#([\w-]+)/g, function(_, sIdValue) {
            if (bXMLDocument) {
                aExprs.push({ key : 'id', op : '=', val : sIdValue });
            }else{
                sId = sIdValue;
            }
            return '';
        });
        
        sTagName = sBody == '*' ? '' : sBody;
    
        /*
         match �Լ� �ڵ� ����� ����
         */
        var oVars = {};
        
        for (var i = 0, oExpr; oExpr = aExprs[i]; i++) {
            
            var sKey = oExpr.key;
            
            if (!oVars[sKey]) aDefineCode.push(getDefineCode(sKey));
            /*
             ����Ŭ���� ���� �˻簡 �� �ڷ� ������ unshift ���
             */
            aReturnCode.unshift(getReturnCode(oExpr));
            oVars[sKey] = true;
            
        }
        
        if (aDefineCode.length) oRet.defines = 'var ' + aDefineCode.join(',') + ';';
        if (aReturnCode.length) oRet.returns = aReturnCode.join('&&');
        
        oRet.quotID = sId ? wrapQuot(sId) : '';
        oRet.quotTAG = sTagName ? wrapQuot(bXMLDocument ? sTagName : sTagName.toUpperCase()) : '';
        
        if (bSupportByClassName) oRet.quotCLASS = sClassName ? wrapQuot(sClassName) : '';
        
        oRet.returnsID = sId ? 'oEl.id == ' + oRet.quotID + ' && ' : '';
        oRet.returnsTAG = sTagName && sTagName != '*' ? 'oEl.tagName == ' + oRet.quotTAG + ' && ' : '';
        
        return oRet;
        
    };
    
    /*
     ������ ������ �������� �߶�
     */
    var splitToParts = function(sQuery) {
        
        var aParts = [];
        var sRel = ' ';
        
        var sBody = sQuery.replace(/(.*?)\s*(!?[+>~ ]|!)\s*/g, function(_, sBody, sRelative) {
            
            if (sBody) aParts.push({ rel : sRel, body : sBody });
    
            sRel = sRelative.replace(/\s+$/g, '') || ' ';
            return '';
            
        });
    
        if (sBody) aParts.push({ rel : sRel, body : sBody });
        
        return aParts;
        
    };
    
    var isNth_dontShrink = function(oEl, sTagName, nMul, nAdd, sDirection) {
        
        var nIndex = 0;
        for (var oSib = oEl; oSib; oSib = oSib[sDirection]){
            if (oSib.nodeType == 1 && (!sTagName || sTagName == oSib.tagName))
                    nIndex++;
        }
            

        return nIndex % nMul == nAdd;

    };
    
    /*
     �߶� part �� �Լ��� ������ �ϱ�
     */
    var compileParts = function(aParts) {
        var aPartExprs = [];
        /*
         �߶� �κе� ���� �����
         */
        for (var i=0,oPart; oPart = aParts[i]; i++)
            aPartExprs.push(getExpression(oPart.body));
        
        //////////////////// BEGIN
        
        var sFunc = '';
        var sPushCode = 'aRet.push(oEl); if (oOptions.single) { bStop = true; }';

        for(var i=aParts.length-1, oPart; oPart = aParts[i]; i--) {
            
            var oExpr = aPartExprs[i];
            var sPush = (debugOption.callback ? 'cost++;' : '') + oExpr.defines;
            

            var sReturn = 'if (bStop) {' + (i == 0 ? 'return aRet;' : 'return;') + '}';
            
            if (oExpr.returns == 'true') {
                sPush += (sFunc ? sFunc + '(oEl);' : sPushCode) + sReturn;
            }else{
                sPush += 'if (' + oExpr.returns + ') {' + (sFunc ? sFunc + '(oEl);' : sPushCode ) + sReturn + '}';
            }
            
            var sCheckTag = 'oEl.nodeType != 1';
            if (oExpr.quotTAG) sCheckTag = 'oEl.tagName != ' + oExpr.quotTAG;
            
            var sTmpFunc =
                '(function(oBase' +
                    (i == 0 ? ', oOptions) { var bStop = false; var aRet = [];' : ') {');

            if (oExpr.nth) {
                sPush =
                    'if (isNth_dontShrink(oEl, ' +
                    (oExpr.quotTAG ? oExpr.quotTAG : 'false') + ',' +
                    oExpr.nth[0] + ',' +
                    oExpr.nth[1] + ',' +
                    '"' + (oExpr.nth[2] == 'nth-of-type' ? 'previousSibling' : 'nextSibling') + '")) {' + sPush + '}';
            }
            
            switch (oPart.rel) {
            case ' ':
                if (oExpr.quotID) {
                    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oCandi = oEl;' +
                        'for (; oCandi; oCandi = (oCandi.parentNode || oCandi._IE5_parentNode)) {' +
                            'if (oCandi == oBase) break;' +
                        '}' +
                        'if (!oCandi || ' + sCheckTag + ') return aRet;' +
                        sPush;
                    
                } else {
                    
                    sTmpFunc +=
                        'var aCandi = getChilds_dontShrink(oBase, ' + (oExpr.quotTAG || '"*"') + ', ' + (oExpr.quotCLASS || 'null') + ');' +
                        'for (var i = 0, oEl; oEl = aCandi[i]; i++) {' +
                            (oExpr.quotCLASS ? 'if (' + sCheckTag + ') continue;' : '') +
                            sPush +
                        '}';
                    
                }
            
                break;
                
            case '>':
                if (oExpr.quotID) {
    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'if ((oEl.parentNode || oEl._IE5_parentNode) != oBase || ' + sCheckTag + ') return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'for (var oEl = oBase.firstChild; oEl; oEl = oEl.nextSibling) {' +
                            'if (' + sCheckTag + ') { continue; }' +
                            sPush +
                        '}';
                    
                }
                
                break;
                
            case '+':
                if (oExpr.quotID) {
    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oPrev;' +
                        'for (oPrev = oEl.previousSibling; oPrev; oPrev = oPrev.previousSibling) { if (oPrev.nodeType == 1) break; }' +
                        'if (!oPrev || oPrev != oBase || ' + sCheckTag + ') return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'for (var oEl = oBase.nextSibling; oEl; oEl = oEl.nextSibling) { if (oEl.nodeType == 1) break; }' +
                        'if (!oEl || ' + sCheckTag + ') { return aRet; }' +
                        sPush;
                    
                }
                
                break;
            
            case '~':
    
                if (oExpr.quotID) {
    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oCandi = oEl;' +
                        'for (; oCandi; oCandi = oCandi.previousSibling) { if (oCandi == oBase) break; }' +
                        'if (!oCandi || ' + sCheckTag + ') return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'for (var oEl = oBase.nextSibling; oEl; oEl = oEl.nextSibling) {' +
                            'if (' + sCheckTag + ') { continue; }' +
                            'if (!markElement_dontShrink(oEl, ' + i + ')) { break; }' +
                            sPush +
                        '}';
    
                }
                
                break;
                
            case '!' :
            
                if (oExpr.quotID) {
                    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'for (; oBase; oBase = (oBase.parentNode || oBase._IE5_parentNode)) { if (oBase == oEl) break; }' +
                        'if (!oBase || ' + sCheckTag + ') return aRet;' +
                        sPush;
                        
                } else {
                    
                    sTmpFunc +=
                        'for (var oEl = (oBase.parentNode || oBase._IE5_parentNode); oEl; oEl = oEl && (oEl.parentNode || oEl._IE5_parentNode)) {'+
                            'if (' + sCheckTag + ') { continue; }' +
                            sPush +
                        '}';
                    
                }
                
                break;
    
            case '!>' :
            
                if (oExpr.quotID) {
    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oRel = (oBase.parentNode || oBase._IE5_parentNode);' +
                        'if (!oRel || oEl != oRel || (' + sCheckTag + ')) return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'var oEl = (oBase.parentNode || oBase._IE5_parentNode);' +
                        'if (!oEl || ' + sCheckTag + ') { return aRet; }' +
                        sPush;
                    
                }
                
                break;
                
            case '!+' :
                
                if (oExpr.quotID) {
    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oRel;' +
                        'for (oRel = oBase.previousSibling; oRel; oRel = oRel.previousSibling) { if (oRel.nodeType == 1) break; }' +
                        'if (!oRel || oEl != oRel || (' + sCheckTag + ')) return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'for (oEl = oBase.previousSibling; oEl; oEl = oEl.previousSibling) { if (oEl.nodeType == 1) break; }' +
                        'if (!oEl || ' + sCheckTag + ') { return aRet; }' +
                        sPush;
                    
                }
                
                break;
    
            case '!~' :
                
                if (oExpr.quotID) {
                    
                    sTmpFunc +=
                        // 'var oEl = oDocument_dontShrink.getElementById(' + oExpr.quotID + ');' +
                        'var oEl = GEBID(oBase,' + oExpr.quotID + ',oDocument_dontShrink);' +
                        'var oRel;' +
                        'for (oRel = oBase.previousSibling; oRel; oRel = oRel.previousSibling) { ' +
                            'if (oRel.nodeType != 1) { continue; }' +
                            'if (oRel == oEl) { break; }' +
                        '}' +
                        'if (!oRel || (' + sCheckTag + ')) return aRet;' +
                        sPush;
                    
                } else {
    
                    sTmpFunc +=
                        'for (oEl = oBase.previousSibling; oEl; oEl = oEl.previousSibling) {' +
                            'if (' + sCheckTag + ') { continue; }' +
                            'if (!markElement_dontShrink(oEl, ' + i + ')) { break; }' +
                            sPush +
                        '}';
                    
                }
                
            }
    
            sTmpFunc +=
                (i == 0 ? 'return aRet;' : '') +
            '})';
            
            sFunc = sTmpFunc;
            
        }

        var fpCompiled;
        eval('fpCompiled=' + sFunc + ';');
        return fpCompiled;
        
    };
    
    /*
     ������ match �Լ��� ��ȯ
     */
    var parseQuery = function(sQuery) {
        var sCacheKey = sQuery;
        
        var fpSelf = arguments.callee;
        var fpFunction = fpSelf._cache[sCacheKey];
        
        if (!fpFunction) {
            
            sQuery = backupKeys(sQuery);
            
            var aParts = splitToParts(sQuery);
            
            fpFunction = fpSelf._cache[sCacheKey] = compileParts(aParts);
            fpFunction.depth = aParts.length;
            
        }
        
        return fpFunction;
        
    };
    
    parseQuery._cache = {};
    
    /*
     test ������ match �Լ��� ��ȯ
     */
    var parseTestQuery = function(sQuery) {
        
        var fpSelf = arguments.callee;
        
        var aSplitQuery = backupKeys(sQuery).split(/\s*,\s*/);
        var aResult = [];
        
        var nLen = aSplitQuery.length;
        var aFunc = [];
        
        for (var i = 0; i < nLen; i++) {

            aFunc.push((function(sQuery) {
                
                var sCacheKey = sQuery;
                var fpFunction = fpSelf._cache[sCacheKey];
                
                if (!fpFunction) {
                    
                    sQuery = backupKeys(sQuery);
                    var oExpr = getExpression(sQuery);
                    
                    eval('fpFunction = function(oEl) { ' + oExpr.defines + 'return (' + oExpr.returnsID + oExpr.returnsTAG + oExpr.returns + '); };');
                    
                }
                
                return fpFunction;
                
            })(restoreKeys(aSplitQuery[i])));
            
        }
        return aFunc;
        
    };
    
    parseTestQuery._cache = {};
    
    var distinct = function(aList) {
    
        var aDistinct = [];
        var oDummy = {};
        
        for (var i = 0, oEl; oEl = aList[i]; i++) {
            
            var nUID = getUID(oEl);
            if (oDummy[nUID]) continue;
            
            aDistinct.push(oEl);
            oDummy[nUID] = true;
        }
    
        return aDistinct;
    
    };
    
    var markElement_dontShrink = function(oEl, nDepth) {
        
        var nUID = getUID(oEl);
        if (cssquery._marked[nDepth][nUID]) return false;
        
        cssquery._marked[nDepth][nUID] = true;
        return true;

    };
    
    var getParentElement = function(oParent){
        if(!oParent) {
            return document;
        }
        
        var nParentNodeType;
        
        oParent = oParent.$value ? oParent.$value() : oParent;
        
        //-@@cssquery-@@//
        if(nv.$Jindo.isString(oParent)){
            try{
                oParent = document.getElementById(oParent);
            }catch(e){
                oParent = document;
            }
        }
        
        nParentNodeType = oParent.nodeType;
        
        if(nParentNodeType != 1 && nParentNodeType != 9 && nParentNodeType != 10 && nParentNodeType != 11){
            oParent = oParent.ownerDocument || oParent.document;
        }
        
        return oParent || oParent.ownerDocument || oParent.document;
    };
    
    var oResultCache = null;
    var bUseResultCache = false;
    var bExtremeMode = false;
        
    var old_cssquery = function(sQuery, oParent, oOptions) {
        var oArgs = g_checkVarType(arguments, {
            '4str'   : [ 'sQuery:String+'],
            '4var'  : [ 'sQuery:String+', 'oParent:Variant' ],
            '4var2' : [ 'sQuery:String+', 'oParent:Variant', 'oOptions:Variant' ]
        },"cssquery");
        
        oParent = getParentElement(oParent);
        oOptions = oOptions && oOptions.$value ? oOptions.$value() : oOptions;
        
        if (typeof sQuery == 'object') {
            
            var oResult = {};
            
            for (var k in sQuery){
                if(sQuery.hasOwnProperty(k))
                    oResult[k] = arguments.callee(sQuery[k], oParent, oOptions);
            }
            
            return oResult;
        }
        
        cost = 0;
        
        var executeTime = new Date().getTime();
        var aRet;
        
        for (var r = 0, rp = debugOption.repeat; r < rp; r++) {
            
            aRet = (function(sQuery, oParent, oOptions) {
                
                if(oOptions){
                    if(!oOptions.oneTimeOffCache){
                        oOptions.oneTimeOffCache = false;
                    }
                }else{
                    oOptions = {oneTimeOffCache:false};
                }
                cssquery.safeHTML(oOptions.oneTimeOffCache);
                
                if (!oParent) oParent = document;
                    
                /*
                 ownerDocument ����ֱ�
                 */
                oDocument_dontShrink = oParent.ownerDocument || oParent.document || oParent;
                
                /*
                 ������ ������ IE5.5 ����
                 */
                if (/\bMSIE\s([0-9]+(\.[0-9]+)*);/.test(nv._p_._j_ag) && parseFloat(RegExp.$1) < 6) {
                    try { oDocument_dontShrink.location; } catch(e) { oDocument_dontShrink = document; }
                    
                    oDocument_dontShrink.firstChild = oDocument_dontShrink.getElementsByTagName('html')[0];
                    oDocument_dontShrink.firstChild._IE5_parentNode = oDocument_dontShrink;
                }
                
                /*
                 XMLDocument ���� üũ
                 */
                bXMLDocument = (typeof XMLDocument !== 'undefined') ? (oDocument_dontShrink.constructor === XMLDocument) : (!oDocument_dontShrink.location);
                getUID = bXMLDocument ? getUID4XML : getUID4HTML;
        
                clearKeys();
                /*
                 ������ ��ǥ�� ������
                 */
                var aSplitQuery = backupKeys(sQuery).split(/\s*,\s*/);
                var aResult = [];
                
                var nLen = aSplitQuery.length;
                
                for (var i = 0; i < nLen; i++)
                    aSplitQuery[i] = restoreKeys(aSplitQuery[i]);
                
                /*
                 ��ǥ�� ������ ���� ����
                 */
                for (var i = 0; i < nLen; i++) {
                    
                    var sSingleQuery = aSplitQuery[i];
                    var aSingleQueryResult = null;
                    
                    var sResultCacheKey = sSingleQuery + (oOptions.single ? '_single' : '');
        
                    /*
                     ��� ĳ�� ����
                     */
                    var aCache = bUseResultCache ? oResultCache[sResultCacheKey] : null;
                    if (aCache) {
                        
                        /*
                         ĳ�̵Ǿ� �ִ°� ������ parent �� �������� �˻����� aSingleQueryResult �� ����
                         */
                        for (var j = 0, oCache; oCache = aCache[j]; j++) {
                            if (oCache.parent == oParent) {
                                aSingleQueryResult = oCache.result;
                                break;
                            }
                        }
                        
                    }
                    
                    if (!aSingleQueryResult) {
                        
                        var fpFunction = parseQuery(sSingleQuery);
                        
                        cssquery._marked = [];
                        for (var j = 0, nDepth = fpFunction.depth; j < nDepth; j++)
                            cssquery._marked.push({});
                        
                        aSingleQueryResult = distinct(fpFunction(oParent, oOptions));
                        
                        /*
                         ��� ĳ�ø� ������̸� ĳ�ÿ� ����
                         */
                        if (bUseResultCache&&!oOptions.oneTimeOffCache) {
                            if (!(oResultCache[sResultCacheKey] instanceof Array)) oResultCache[sResultCacheKey] = [];
                            oResultCache[sResultCacheKey].push({ parent : oParent, result : aSingleQueryResult });
                        }
                        
                    }
                    
                    aResult = aResult.concat(aSingleQueryResult);
                    
                }
                unsetNodeIndexes();
        
                return aResult;
                
            })(sQuery, oParent, oOptions);
            
        }
        
        executeTime = new Date().getTime() - executeTime;

        if (debugOption.callback) debugOption.callback(sQuery, cost, executeTime);
        
        return aRet;
        
    };
    var cssquery;
    if (document.querySelectorAll) {
        function _isNonStandardQueryButNotException(sQuery){
            return /\[\s*(?:checked|selected|disabled)/.test(sQuery);
        }
        function _commaRevise (sQuery,sChange) {
            return sQuery.replace(/\,/gi,sChange);
        }
        function _startCombinator (sQuery) {
            return /^[~>+]/.test(sQuery);
        }
        function _addQueryId(el, sIdName){
            var sQueryId, sValue;
        
            if(/^\w+$/.test(el.id)){
                sQueryId = "#" + el.id;
            }else{
                sValue = "C" + new Date().getTime() + Math.floor(Math.random() * 1000000);
                el.setAttribute(sIdName, sValue);
                sQueryId = "[" + sIdName + "=" + sValue + "]";
            }
            
            return sQueryId;
        }
        function _getSelectorMethod(sQuery, bDocument) {
            var oRet = { method : null, query : null };

            if(/^\s*[a-z]+\s*$/i.test(sQuery)) {
                oRet.method = "getElementsByTagName";
            } else if(/^\s*([#\.])([\w\-]+)\s*$/i.test(sQuery)) {
                oRet.method = RegExp.$1 == "#" ? "getElementById" : "getElementsByClassName";
                oRet.query = RegExp.$2;
            }
            
            if(!document[oRet.method] || RegExp.$1 == "#" && !bDocument) {
                oRet.method = oRet.query = null;
            }

            return oRet;
        }
        
        var _div = document.createElement("div");

        /**
          @lends $$
         */
        cssquery = function(sQuery, oParent, oOptions){
            var oArgs = g_checkVarType(arguments, {
                '4str'   : [ 'sQuery:String+'],
                '4var'  : [ 'sQuery:String+', 'oParent:Variant' ],
                '4var2' : [ 'sQuery:String+', 'oParent:Variant', 'oOptions:Variant' ]
            },"cssquery"),
            sTempId, aRet, nParentNodeType, bUseQueryId, oOldParent, queryid, _clone, sTagName, _parent, vSelectorMethod, sQueryAttrName = "queryid";
            
            oParent = getParentElement(oParent);
            oOptions = oOptions && oOptions.$value ? oOptions.$value() : oOptions;
            
            /*
            	[key=val]�� �� val�� �����̸�  ''�� �����ִ� ����
            */
            var re = /\[(.*?)=([\w\d]*)\]/g;

            if(re.test(sQuery)) {
                sQuery = sQuery.replace(re, "[$1='$2']");
            }
            
            nParentNodeType = oParent.nodeType;
            
            try{
                if(_isNonStandardQueryButNotException(sQuery)){
                    return old_cssquery(sQuery, oParent, oOptions);
                }
                sTagName = (oParent.tagName||"").toUpperCase();
                
                vSelectorMethod = _getSelectorMethod(sQuery, nParentNodeType == 9);

                if(vSelectorMethod.query) {
                    sQuery = vSelectorMethod.query;
                }
                
                vSelectorMethod = vSelectorMethod.method;

                if(nParentNodeType!==9&&sTagName!="HTML"){
                    if(nParentNodeType === 11){
                        /*
                        	documentFragment�� �� �� �����ؼ� ã��.
                        */
                        oParent = oParent.cloneNode(true);
                        _clone = _div.cloneNode(true);
                        _clone.appendChild(oParent);
                        oParent = _clone;
                        _clone = null;
                    }
                    
                    if(!vSelectorMethod) {                      
                        bUseQueryId = true;
                        queryid = _addQueryId(oParent, sQueryAttrName);
                        sQuery = _commaRevise(queryid+" "+ sQuery,", "+queryid+" ");
                    }

                    if((_parent = oParent.parentNode) || sTagName === "BODY" || nv.$Element._contain((oParent.ownerDocument || oParent.document).body,oParent)) {
                        /*
                        	���� ���� ���� ���� ������Ʈ�� ��������
                        */
                        if(!vSelectorMethod) {
                            oOldParent = oParent;
                            oParent = _parent;
                        }
                        
                    } else if(!vSelectorMethod) {
                        /*
                        	���� ������ ��쿡�� ���� ������Ʈ�� ���� Ž��.
                        */
                        _clone = _div.cloneNode(true);
                        // id = oParent.id;
                        oOldParent = oParent;
                        _clone.appendChild(oOldParent);
                        oParent = _clone;
                    }

                } else {
                    oParent = (oParent.ownerDocument || oParent.document||oParent);
                    if(_startCombinator(sQuery)) return [];
                }

                if(oOptions&&oOptions.single) {
                    if(vSelectorMethod) {
                        aRet = oParent[vSelectorMethod](sQuery);
                        aRet = [ vSelectorMethod == "getElementById" ? aRet : aRet[0] ];
                    } else {
                        aRet = [ oParent.querySelector(sQuery) ];
                    }

                } else {
                    if(vSelectorMethod) {
                        aRet = oParent[vSelectorMethod](sQuery);

                        if(vSelectorMethod == "getElementById") {
                            aRet = aRet ? [aRet] : [];
                        }
                    } else {
                        aRet = oParent.querySelectorAll(sQuery);    
                    }
                    
                    aRet = nv._p_._toArray(aRet);
                }
                
            } catch(e) {
                aRet =  old_cssquery(sQuery, oParent, oOptions);
            }

            if(bUseQueryId){
                oOldParent.removeAttribute(sQueryAttrName);
                _clone = null;
            }
            return aRet;
        };
    }else{
        cssquery = old_cssquery;
    }
    /**
     	test() �޼���� Ư�� ��Ұ� �ش� CSS ������(CSS Selector)�� �����ϴ� ������� �Ǵ��Ͽ� Boolean ���·� ��ȯ�Ѵ�.
	
	@method $$.test
	@static
	@param {Element+} element �˻��ϰ��� �ϴ� ���
	@param {String+} sCSSSelector CSS ������. CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS Level3 ������ �ִ� ������ �����Ѵ�.
	@return {Boolean} ���ǿ� �����ϸ� true, �������� ������ false�� ��ȯ�Ѵ�.
	@remark 
		<ul class="disc">
			<li>CSS �����ڿ� �����ڴ� ����� �� ������ �����Ѵ�.</li>
			<li>�������� ���Ͽ� ���� ������ $$() �Լ��� See Also �׸��� �����Ѵ�.</li>
		</ul>
	@see nv.$$
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
	@example
		// oEl �� div �±� �Ǵ� p �±�, �Ǵ� align �Ӽ��� center�� ������ ������� �˻��Ѵ�.
		if (cssquery.test(oEl, 'div, p, [align=center]'))
		alert('�ش� ���� ����');
     */
    cssquery.test = function(oEl, sQuery) {
        clearKeys();
        try{
            var oArgs = g_checkVarType(arguments, {
                '4ele' : [ 'oEl:Element+', 'sQuery:String+' ],
                '4doc' : [ 'oEl:Document+', 'sQuery:String+' ]
            },"<static> cssquery#test");
            oEl = oArgs.oEl;
            sQuery = oArgs.sQuery;
        }catch(e){
            return false;
        }

        var aFunc = parseTestQuery(sQuery);

        for (var i = 0, nLen = aFunc.length; i < nLen; i++){
            if (aFunc[i](oEl)) return true;
        }

        return false;
    };

    /**
     	useCache() �޼���� $$() �Լ�(cssquery)�� ����� �� ĳ�ø� ����� ������ �����Ѵ�. ĳ�ø� ����ϸ� ������ �����ڷ� Ž���ϴ� ��� Ž������ �ʰ� ���� Ž�� ����� ��ȯ�Ѵ�. ���� ����ڰ� ���� ĳ�ø� �Ű澲�� �ʰ� ���ϰ� ������ ����� �� �ִ� ������ ������ �ŷڼ��� ���� DOM ������ �������� ������ ���� ���� ����ؾ� �Ѵ�.
	
	@method $$.useCache
	@static
	@param {Boolean} [bFlag] ĳ??? ��� ���θ� �����Ѵ�. �� �Ķ���͸� �����ϸ� ĳ�� ��� ���¸� ��ȯ�Ѵ�.
	@return {Boolean} ĳ�� ��� ���¸� ��ȯ�Ѵ�.
	@see nv.$$.clearCache
     */
    cssquery.useCache = function(bFlag) {
    
        if (bFlag !== undefined) {
            bUseResultCache = bFlag;
            cssquery.clearCache();
        }
        
        return bUseResultCache;
        
    };
    
    /**
     	clearCache() �޼���� $$() �Լ�(cssquery)���� ĳ�ø� ����� �� ĳ�ø� ��� �� ����Ѵ�. DOM ������ �������� �ٲ� ������ ĳ�� �����Ͱ� �ŷڼ��� ���� �� ����Ѵ�.
	
	@method $$.clearCache
	@static
	@see nv.$$.useCache
     */
    cssquery.clearCache = function() {
        oResultCache = {};
    };
    
    /**
     	getSingle() �޼���� CSS �����ڸ� ��뿡�� ������ �����ϴ� ù ��° ��Ҹ� �����´�. ��ȯ�ϴ� ���� �迭�� �ƴ� ��ä �Ǵ� null�̴�. ������ �����ϴ� ��Ҹ� ã���� �ٷ� Ž�� �۾��� �ߴ��ϱ� ������ ����� �ϳ���� ������ ���� �� ���� �ӵ��� ����� ������ �� �ִ�.
	
	@method $$.getSingle
	@static
	@syntax sSelector, oBaseElement, oOption
	@syntax sSelector, sBaseElement, oOption
	@param {String+} sSelector CSS ������(CSS Selector). CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS3 Level3 ������ �ִ� ������ �����Ѵ�. �������� ���Ͽ� ���� ������ $$() �Լ��� See Also �׸��� �����Ѵ�.
	@param {Element+} [oBaseElement] Ž�� ����� �Ǵ� DOM ���. ������ ����� ���� ��忡���� ��ü�� Ž���Ѵ�. ������ ��� ������ ������� ã�´�.
	@param {Hash+} [oOption] �ɼ� ��ü�� oneTimeOffCache �Ӽ��� true�� �����ϸ� Ž���� �� ĳ�ø� ������� �ʴ´�.
	@param {String+} [sBaseElement] Ž�� ����� �Ǵ� DOM ����� ID. ������ ����� ���� ��忡���� ��ü�� Ž���Ѵ�. ������ ��� ������ ������� ã�´�.  ID�� ���� �� �ִ�.
	@return {Element | Boolean} ���õ� ���. ����� ������ null�� ��ȯ�Ѵ�.
	@see nv.$Document#query	 
	@see nv.$$.useCache
	@see nv.$$
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
     */
    cssquery.getSingle = function(sQuery, oParent, oOptions) {

        oOptions = oOptions && oOptions.$value ? oOptions.$value() : oOptions; 

        return cssquery(sQuery, oParent, {
            single : true ,
            oneTimeOffCache:oOptions?(!!oOptions.oneTimeOffCache):false
        })[0] || null;
    };
    
    
    /**
     	xpath() �޼���� XPath ������ �����ϴ� ��Ҹ� �����´�. �����ϴ� ������ �������̹Ƿ� Ư���� ��쿡�� ����� ���� �����Ѵ�.
	
	@method $$.xpath
	@static
	@param {String+} sXPath XPath ��.
	@param {Element} [elBaseElement] Ž�� ����� �Ǵ� DOM ���. ������ ����� ���� ��忡���� ��ü�� Ž���Ѵ�. 
	@return {Array | Boolean} XPath ������ �����ϴ� ��Ҹ� ���ҷ� �ϴ� �迭. ����� ������ null�� ��ȯ�Ѵ�.
	@filter desktop
	@see nv.$Document#xpathAll
	@see http://www.w3.org/standards/techs/xpath#w3c_all XPath ���� - W3C
     */
    cssquery.xpath = function(sXPath, oParent) {
        sXPath = sXPath && sXPath.$value ? sXPath.$value() : sXPath; 
        
        sXPath = sXPath.replace(/\/(\w+)(\[([0-9]+)\])?/g, function(_1, sTag, _2, sTh) {
            sTh = sTh || '1';
            return '>' + sTag + ':nth-of-type(' + sTh + ')';
        });
        
        return old_cssquery(sXPath, oParent);
    };
    
    /**
     	debug() �޼���� $$() �Լ�(cssquery)�� ����� �� ������ �����ϱ� ���� ����� �����ϴ� �Լ��̴�. �Ķ���ͷ� �Է��� �ݹ� �Լ��� ����Ͽ� ������ �����Ѵ�.
	
	@method $$.debug
	@static
	@param {Function} fCallback ������ ���࿡ �ҿ�� ���� �ð��� �����ϴ� �Լ�. �� �Ķ���Ϳ� �Լ� ��� false�� �Է��ϸ� ���� ���� ���(debug)�� ������� �ʴ´�.
	@param {Numeric} [nRepeat] �ϳ��� �����ڸ� �ݺ� ������ Ƚ��. ���������� ���� �ӵ��� ���߱� ���� ����� �� �ִ�.
	@filter desktop
	@remark �ݹ� �Լ� fCallback�� �Ķ���ͷ� query, cost, executeTime�� ���´�.<br>
		<ul class="disc">
			<li>query�� ���࿡ ���� �������̴�.</li>
			<li>index�� Ž���� ���� ����̴�(���� Ƚ��).</li>
			<li>executeTime Ž���� �ҿ�� �ð��̴�.</li>
		</ul>
	@example
		cssquery.debug(function(sQuery, nCost, nExecuteTime) {
			if (nCost > 5000)
				console.warn('5000�� �Ѵ� �����? Ȯ�� -> ' + sQuery + '/' + nCost);
			else if (nExecuteTime > 200)
				console.warn('0.2�ʰ� �Ѱ� ������? Ȯ�� -> ' + sQuery + '/' + nExecuteTime);
		}, 20);
		
		....
		
		cssquery.debug(false);
     */
    cssquery.debug = function(fpCallback, nRepeat) {
        
        var oArgs = g_checkVarType(arguments, {
            '4fun'   : [ 'fpCallback:Function+'],
            '4fun2'  : [ 'fpCallback:Function+', 'nRepeat:Numeric' ]
        },"<static> cssquery#debug");

        debugOption.callback = oArgs.fpCallback;
        debugOption.repeat = oArgs.nRepeat || 1;
        
    };
    
    /**
     	safeHTML() �޼���� ���ͳ� �ͽ��÷η����� innerHTML �Ӽ��� ����� �� _cssquery_UID ���� ������ �ʰ� �ϴ� �Լ��̴�. true�� �����ϸ� Ž���ϴ� ����� innerHTML �Ӽ��� _cssquery_UID�� ������ �ʰ� �� �� ������ Ž�� �ӵ��� ������ �� �ִ�.
	
	@method $$.safeHTML
	@static
	@param {Boolean} bFlag _cssquery_UID�� ǥ�� ���θ� �����Ѵ�. true�� �����ϸ� _cssquery_UID�� ������ �ʴ´�.
	@return {Boolean} _cssquery_UID ǥ�� ���� ���¸� ��ȯ�Ѵ�. _cssquery_UID�� ǥ���ϴ� �����̸� true�� ��ȯ�ϰ� �׷��� ������ false�� ��ȯ�Ѵ�.
	@filter desktop
     */
    cssquery.safeHTML = function(bFlag) {
        
        if (arguments.length > 0)
            safeHTML = bFlag && nv._p_._JINDO_IS_IE;
        
        return safeHTML || !nv._p_._JINDO_IS_IE;
        
    };
    
    /**
     	version �Ӽ��� cssquery�� ���� ������ ��� �ִ� ���ڿ��̴�.
	
	@property $$.version
	@type String
	@field
	@static
	@filter desktop
     */
    cssquery.version = sVersion;
    
    /**
     	IE���� validUID,cache�� ��������� �޸� ���� �߻��Ͽ� �����ϴ� ��� �߰�.x
     */
    cssquery.release = function() {
        if(nv._p_._JINDO_IS_IE) {
            delete validUID;
            validUID = {};
            
            if(bUseResultCache){
                cssquery.clearCache();
            }
        }
    };
    /**
     	cache�� ������ �Ǵ��� Ȯ���ϱ� ���� �ʿ��� �Լ�
	
	@method $$._getCacheInfo
	@filter desktop
	@ignore
     */
    cssquery._getCacheInfo = function(){
        return {
            uidCache : validUID,
            eleCache : oResultCache 
        };
    };
    /**
     	�׽�Ʈ�� ���� �ʿ��� �Լ�
	
	@method $$._resetUID
	@filter desktop
	@ignore
     */
    cssquery._resetUID = function(){
        UID = 0;
    };
    /**
     	querySelector�� �ִ� ���������� extreme�� �����Ű�� querySelector�� ����Ҽ� �ִ� Ŀ�������� ������ ��ü������ �ӵ��� ��������.
	������ ID�� ���� ������Ʈ�� ���� ������Ʈ�� �־��� �� ���� ������Ʈ�� ������ ���̵� ����.
	
	@method $$.extreme
	@static
	@ignore
	@param {Boolean} bExtreme true
     */
    cssquery.extreme = function(bExtreme){
        if(arguments.length == 0){
            bExtreme = true;
        }
        bExtremeMode = bExtreme;
    };

    return cssquery;
    
})();
//-!nv.cssquery end!-//
//-!nv.$$.hidden start(nv.cssquery)!-//
//-!nv.$$.hidden end!-//

/**
 * 
	@fileOverview nv.$Agent() ��ü�� ������ �� �޼��带 ������ ����
	@name core.js
	@author NAVER Ajax Platform
 */

//-!nv.$Agent start!-//
/**
	nv.$Agent() ��ü�� �ü��, �������� ����� ����� �ý��� ������ �����Ѵ�.
	
	@class nv.$Agent
	@keyword agent, ������Ʈ
 */
/**
	nv.$Agent() ��ü�� �����Ѵ�. nv.$Agent() ��ü�� ����� �ý����� � ü�� ������ ������ ������ �����Ѵ�.
	
	@constructor
 */
nv.$Agent = function() {
	//-@@$Agent-@@//
	var cl = arguments.callee;
	var cc = cl._cached;

	if (cc) return cc;
	if (!(this instanceof cl)) return new cl;
	if (!cc) cl._cached = this;

	this._navigator = navigator;
	this._dm = document.documentMode;
};
//-!nv.$Agent end!-//

//-!nv.$Agent.prototype.navigator start!-//
/**
	navigator() �޼���� ����� ������ ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method navigator
	@return {Object} ������ ������ �����ϴ� ��ü.
	@remark 
		<ul class="disc">
			<li>1.4.3 �������� mobile,msafari,mopera,mie ��� ����.</li>
			<li>1.4.5 �������� ipad���� mobile�� false�� ��ȯ�Ѵ�.</li>
		</ul><br>
		������ ������ �����ϴ� ��ü�� ������ �̸��� ������ �Ӽ����� ������. ������ �̸��� ���� �ҹ��ڷ� ǥ���ϸ�, ������� �������� ��ġ�ϴ� ������ �Ӽ��� true ���� ������. 
		����, ������� ������ �̸��� Ȯ���� �� �ֵ��� �޼��带 �����Ѵ�. ������ ����� ������ ������ ��� �ִ� ��ü�� �Ӽ��� �޼��带 ������ ǥ�̴�.<br>
		<h5>������ ���� ��ü �Ӽ�</h5>
		<table class="tbl_board">
			<caption class="hide">������ ���� ��ü �Ӽ�</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">camino</td>
					<td>Boolean</td>
					<td class="txt">ī�̳�(Camino) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">chrome</td>
					<td>Boolean</td>
					<td class="txt">���� ũ��(Chrome) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">firefox</td>
					<td>Boolean</td>
					<td class="txt">���̾�����(Firefox) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�. </td>
				</tr>
				<tr>
					<td class="txt bold">icab</td>
					<td>Boolean</td>
					<td class="txt">iCab ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">ie</td>
					<td>Boolean</td>
					<td class="txt">���ͳ� �ͽ��÷η�(Internet Explorer) ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">konqueror</td>
					<td>Boolean</td>
					<td class="txt">Konqueror ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">mie</td>
					<td>Boolean</td>
					<td class="txt">���ͳ� �ͽ��÷η� �����(Internet Explorer Mobile) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">mobile</td>
					<td>Boolean</td>
					<td class="txt">����� ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">mozilla</td>
					<td>Boolean</td>
					<td class="txt">������(Mozilla) �迭�� ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">msafari</td>
					<td>Boolean</td>
					<td class="txt">Mobile ���� Safari ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">nativeVersion</td>
					<td>Number</td>
					<td class="txt">���ͳ� �ͽ��÷η� ȣȯ ����� �������� ����� ��� ���� �������� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">netscape</td>
					<td>Boolean</td>
					<td class="txt">�ݽ�������(Netscape) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">omniweb</td>
					<td>Boolean</td>
					<td class="txt">OmniWeb ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">opera</td>
					<td>Boolean</td>
					<td class="txt">�����(Opera) ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">safari</td>
					<td>Boolean</td>
					<td class="txt">Safari ������ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">webkit</td>
					<td>Number</td>
					<td class="txt">WebKit �迭 �ζ���� ��� ���θ� �Ҹ��� ���·� �����Ѵ�. </td>
				</tr>
				<tr>
					<td class="txt bold">version</td>
					<td>Number</td>
					<td class="txt">����ڰ� ����ϰ� �ִ� �������� ���� ������ �����Ѵ�. �Ǽ�(Float) ���·� ���� ������ �����ϸ� ���� ������ ������ -1 ���� ������.</td>
				</tr>
			</tbody>
		</table>
		<h5>������ ���� ��ü �޼���</h5>
		<table class="tbl_board">
			<caption class="hide">������ ���� ��ü �޼���</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">��ȯ Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">getName()</td>
					<td>String</td>
					<td class="txt">����ڰ� ����ϰ� �ִ� �������� �̸��� ��ȯ�Ѵ�. ��ȯ�ϴ� �������� �̸��� �Ӽ� �̸��� �����ϴ�.</td>
				</tr>
			</tbody>
		</table>
	@example
		oAgent = $Agent().navigator(); // ����ڰ� ���̾����� 3�� ����Ѵٰ� �����Ѵ�.
		
		oAgent.camino  // false
		oAgent.firefox  // true
		oAgent.konqueror // false
		oAgent.mozilla  //true
		oAgent.netscape  // false
		oAgent.omniweb  //false
		oAgent.opera  //false
		oAgent.webkit  /false
		oAgent.safari  //false
		oAgent.ie  //false
		oAgent.chrome  //false
		oAgent.icab  //false
		oAgent.version  //3
		oAgent.nativeVersion // -1 (1.4.2���� ��� ����, IE8���� ȣȯ ��� ���� nativeVersion�� 8�� ����.)
		
		oAgent.getName() // firefox
 */
nv.$Agent.prototype.navigator = function() {
	//-@@$Agent.navigator-@@//
	var info = {},
		ver = -1,
		nativeVersion = -1,
		u = this._navigator.userAgent,
		v = this._navigator.vendor || "",
		dm = this._dm;

	function f(s,h){
		return ((h || "").indexOf(s) > -1);
	}

	info.getName = function(){
		var name = "";
		for(var x in info){
			if(x !=="mobile" && typeof info[x] == "boolean" && info[x] && info.hasOwnProperty(x))
				name = x;
		}
		return name;
	};

	info.webkit = f("WebKit", u);
	info.opera = (window.opera !== undefined) || f("Opera", u) || f("OPR", u);
	info.ie = !info.opera && (f("MSIE", u)||f("Trident", u));
	info.chrome = info.webkit && !info.opera && f("Chrome", u) || f("CriOS", u);
	info.safari = info.webkit && !info.chrome && !info.opera && f("Apple", v);
	info.firefox = f("Firefox", u);
	info.mozilla = f("Gecko", u) && !info.safari && !info.chrome && !info.firefox && !info.ie;
	info.camino = f("Camino", v);
	info.netscape = f("Netscape", u);
	info.omniweb = f("OmniWeb", u);
	info.icab = f("iCab", v);
	info.konqueror = f("KDE", v);
	info.mobile = (f("Mobile", u) || f("Android", u) || f("Nokia", u) || f("webOS", u) || f("Opera Mini", u) || f("Opera Mobile", u) || f("BlackBerry", u) || (f("Windows", u) && f("PPC", u)) || f("Smartphone", u) || f("IEMobile", u)) && !(f("iPad", u) || f("Tablet", u));
	info.msafari = ((!f("IEMobile", u) && f("Mobile", u)) || (f("iPad", u) && f("Safari", u))) && !info.chrome && !info.opera && !info.firefox;
	info.mopera = f("Opera Mini", u);
	info.mie = f("PPC", u) || f("Smartphone", u) || f("IEMobile", u);

	try{
		if(info.ie){
			if(dm > 0){
				ver = dm;
				if(u.match(/(?:Trident)\/([\d.]+)/)){
					var nTridentNum = parseFloat(RegExp.$1, 10);
					
					if(nTridentNum > 3){
						nativeVersion = nTridentNum + 4;
					}
				}else{
					nativeVersion = ver;
				}
			}else{
				nativeVersion = ver = u.match(/(?:MSIE) ([\d.]+)/)[1];
			}
		}else if(info.safari || info.msafari){
			ver = parseFloat(u.match(/Safari\/([\d.]+)/)[1]);

			if(ver == 100){
				ver = 1.1;
			}else{
				if(u.match(/Version\/([\d.]+)/)){
					ver = RegExp.$1;
				}else{
					ver = [1.0, 1.2, -1, 1.3, 2.0, 3.0][Math.floor(ver / 100)];
				}
			}
        } else if(info.mopera) {
            ver = u.match(/(?:Opera\sMini)\/([\d.]+)/)[1];
        } else if(info.opera) {
            ver = u.match(/(?:Version|OPR|Opera)[\/\s]?([\d.]+)(?!.*Version)/)[1];
		}else if(info.firefox||info.omniweb){
			ver = u.match(/(?:Firefox|OmniWeb)\/([\d.]+)/)[1];
		}else if(info.mozilla){
			ver = u.match(/rv:([\d.]+)/)[1];
		}else if(info.icab){
			ver = u.match(/iCab[ \/]([\d.]+)/)[1];
		}else if(info.chrome){
			ver = u.match(/(?:Chrome|CriOS)[ \/]([\d.]+)/)[1];
		}
		
		info.version = parseFloat(ver);
		info.nativeVersion = parseFloat(nativeVersion);
		
		if(isNaN(info.version)){
			info.version = -1;
		}
	}catch(e){
		info.version = -1;
	}
	
	this.navigator = function(){
		return info;
	};
	
	return info;
};
//-!nv.$Agent.prototype.navigator end!-//

//-!nv.$Agent.prototype.os start!-//
/**
	os() �޼���� ����� �ü�� ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method os
	@return {Object} �ü�� ������ �����ϴ� ��ü.
	@remark
		<ul class="disc">
			<li>1.4.3 �������� iphone, android, nokia, webos, blackberry, mwin ��� ����.</li>
			<li>1.4.5 �������� ipad ��� ����.</li>
			<li>2.3.0 �������� ios, symbianos, version, win8 ��� ����</li>
		</ul><br>
		�ü�� ������ �����ϴ� ��ü�� �ü�� �̸��� �Ӽ����� ������. � ü�� �Ӽ��� ���� �ҹ��ڷ� ǥ���ϸ�, ������� �ü���� ��ġ�ϴ� �ü���� �Ӽ��� true ���� ������.<br>
		���� ������� �ü�� �̸��� Ȯ���� �� �ֵ��� �޼��带 �����Ѵ�. ������ ����� �ü�� ������ ��� �ִ� ��ü�� �Ӽ��� �޼��带 ������ ǥ�̴�.<br>
		<h5>�ü�� ���� ��ü �Ӽ�</h5>
		<table class="tbl_board">
			<caption class="hide">�ü�� ���� ��ü �Ӽ�</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">Ÿ��</th>
					<th scope="col">����</th>
					<th scope="col" style="width:25%">��Ÿ</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">android</td>
					<td>Boolean</td>
					<td class="txt">Android �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">1.4.3 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">blackberry</td>
					<td>Boolean</td>
					<td class="txt">Blackberry �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�. </td>
					<td class="txt">1.4.3 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">ios</td>
					<td>Boolean</td>
					<td class="txt">iOS �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">2.3.0 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">ipad</td>
					<td>Boolean</td>
					<td class="txt">iPad ��ġ ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">1.4.5 �������� ��밡��/���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">iphone</td>
					<td>Boolean</td>
					<td class="txt">iPhone ��ġ���� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">1.4.3 �������� ��밡��/���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">linux</td>
					<td>Boolean</td>
					<td class="txt">Linux�ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt"></td>
				</tr>
				<tr>
					<td class="txt bold">mac</td>
					<td>Boolean</td>
					<td class="txt">Mac�ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt"></td>
				</tr>
				<tr>
					<td class="txt bold">mwin</td>
					<td>Boolean</td>
					<td class="txt">Window Mobile �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">1.4.3 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">nokia</td>
					<td>Boolean</td>
					<td class="txt">Nokia �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">1.4.3 �������� ��� ���� / ���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">symbianos</td>
					<td>Boolean</td>
					<td class="txt">SymbianOS �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">2.3.0 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">vista</td>
					<td>Boolean</td>
					<td class="txt">Windows Vista �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">webos</td>
					<td>Boolean</td>
					<td>webOS �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td>1.4.3 �������� ��� ����</td>
				</tr>
				<tr>
					<td class="txt bold">win</td>
					<td>Boolean</td>
					<td class="txt">Windows�迭 �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt"></td>
				</tr>
				<tr>
					<td class="txt bold">win2000</td>
					<td>Boolean</td>
					<td class="txt">Windows 2000�ü�� ��� ���� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">win7</td>
					<td>Boolean</td>
					<td class="txt">Windows 7 �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">win8</td>
					<td>Boolean</td>
					<td class="txt">Windows 8 �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">2.3.0 ���� ��� ����/���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">winxp</td>
					<td>Boolean</td>
					<td class="txt">Windows XP �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">xpsp2</td>
					<td>Boolean</td>
					<td class="txt">Windows XP SP 2 �ü�� ��� ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
					<td class="txt">���� ����</td>
				</tr>
				<tr>
					<td class="txt bold">version</td>
					<td>String</td>
					<td class="txt">�ü���� ���� ���ڿ�. ������ ã�� ���� ��� null�� �����ȴ�.</td>
					<td class="txt">2.3.0 �������� ��� ����</td>
				</tr>
			</tbody>
		</table>
		<h5>�ü�� ���� ��ü �޼���</h5>
		<table class="tbl_board">
			<caption class="hide">�ü�� ���� ��ü �޼���</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">��ȯ Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">getName()</td>
					<td>String</td>
					<td class="txt">����ڰ� ����ϰ� �ִ� �ü���� �̸��� ��ȯ�Ѵ�. ��ȯ�ϴ� �ü���� �̸��� �Ӽ� �̸��� �����ϴ�.</td>
				</tr>
			</tbody>
		</table>
		<h5>�ü���� ���� ����</h5>
		<table class="tbl_board">
			<caption class="hide">�ü���� ���� ����</caption>
			<thead>
				<tr>
					<th scope="col" style="width:60%">�ü�� �̸�</th>
					<th scope="col">���� ��</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">Windows 2000</td>
					<td>5.0</td>
				</tr>
				<tr>
					<td class="txt bold">Windows XP</td>
					<td>5.1</td>
				</tr>
				<tr>
					<td class="txt bold">Windows VISTA</td>
					<td>6.0</td>
				</tr>
				<tr>
					<td class="txt bold">Windows 7</td>
					<td>6.1</td>
				</tr>
				<tr>
					<td class="txt bold">Windows 8</td>
					<td>6.2</td>
				</tr>
				<tr>
					<td class="txt bold">Windows 8.1</td>
					<td>6.3</td>
				</tr>
				<tr>
					<td class="txt bold">OS X Tiger</td>
					<td>10.4</td>
				</tr>
				<tr>
					<td class="txt bold">OS X Leopard</td>
					<td>10.5</td>
				</tr>
				<tr>
					<td class="txt bold">OS X Snow Leopard</td>
					<td>10.6</td>
				</tr>
				<tr>
					<td class="txt bold">OS X Lion</td>
					<td>10.7</td>
				</tr>
				<tr>
					<td class="txt bold">OS X Mountain Lion</td>
					<td>10.8</td>
				</tr>
			</tbody>
		</table>
	@example
		var oOS = $Agent().os();  // ������� �ü���� Windows XP��� �����Ѵ�.
		oOS.linux  // false
		oOS.mac  // false
		oOS.vista  // false
		oOS.win  // true
		oOS.win2000  // false
		oOS.winxp  // true
		oOS.xpsp2  // false
		oOS.win7  // false
		oOS.getName() // winxp
	@example
		var oOS = $Agent().os();  // �ܸ��Ⱑ iPad�̰� ������ 5.0 �̶�� �����Ѵ�.
		info.ipad; // true
		info.ios; // true
		info.version; // "5.0"
		
		info.win; // false
		info.mac; // false
		info.linux; // false
		info.win2000; // false
		info.winxp; // false
		info.xpsp2; // false
		info.vista; // false
		info.win7; // false
		info.win8; // false
		info.iphone; // false
		info.android; // false
		info.nokia; // false
		info.webos; // false
		info.blackberry; // false
		info.mwin; // false
		info.symbianos; // false
 */
nv.$Agent.prototype.os = function() {
	//-@@$Agent.os-@@//
	var info = {},
		u = this._navigator.userAgent,
		p = this._navigator.platform,
		f = function(s, h) {
			return (h.indexOf(s) > -1);
		},
		aMatchResult = null;
	
	info.getName = function(){
		var name = "";
		
		for(var x in info){
			if(info[x] === true && info.hasOwnProperty(x)){
				name = x;
			}
		}
		
		return name;
	};

	info.win = f("Win", p);
	info.mac = f("Mac", p);
	info.linux = f("Linux", p);
	info.win2000 = info.win && (f("NT 5.0", u) || f("Windows 2000", u));
	info.winxp = info.win && f("NT 5.1", u);
	info.xpsp2 = info.winxp && f("SV1", u);
	info.vista = info.win && f("NT 6.0", u);
	info.win7 = info.win && f("NT 6.1", u);
	info.win8 = info.win && f("NT 6.2", u);
	info.ipad = f("iPad", u);
	info.iphone = f("iPhone", u) && !info.ipad;
	info.android = f("Android", u);
	info.nokia =  f("Nokia", u);
	info.webos = f("webOS", u);
	info.blackberry = f("BlackBerry", u);
	info.mwin = f("PPC", u) || f("Smartphone", u) || f("IEMobile", u) || f("Windows Phone", u);
	info.ios = info.ipad || info.iphone;
	info.symbianos = f("SymbianOS", u);
	info.version = null;
	
	if(info.win){
		aMatchResult = u.match(/Windows NT ([\d|\.]+)/);
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
	}else if(info.mac){
		aMatchResult = u.match(/Mac OS X ([\d|_]+)/);
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = String(aMatchResult[1]).split("_").join(".");
		}

	}else if(info.android){
		aMatchResult = u.match(/Android ([\d|\.]+)/);
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
	}else if(info.ios){
		aMatchResult = u.match(/(iPhone )?OS ([\d|_]+)/);
		if(aMatchResult != null && aMatchResult[2] != undefined){
			info.version = String(aMatchResult[2]).split("_").join(".");
		}
	}else if(info.blackberry){
		aMatchResult = u.match(/Version\/([\d|\.]+)/); // 6 or 7
		if(aMatchResult == null){
			aMatchResult = u.match(/BlackBerry\s?\d{4}\/([\d|\.]+)/); // 4.2 to 5.0
		}
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
	}else if(info.symbianos){
		aMatchResult = u.match(/SymbianOS\/(\d+.\w+)/); // exist 7.0s
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
	}else if(info.webos){
		aMatchResult = u.match(/webOS\/([\d|\.]+)/);
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
	}else if(info.mwin){
		aMatchResult = u.match(/Windows CE ([\d|\.]+)/);
		if(aMatchResult != null && aMatchResult[1] != undefined){
			info.version = aMatchResult[1];
		}
		if(!info.version && (aMatchResult = u.match(/Windows Phone (OS )?([\d|\.]+)/))){
			info.version = aMatchResult[2];
		}
	}
	
	this.os = function() {
		return info;
	};

	return info;
};
//-!nv.$Agent.prototype.os end!-//

//-!nv.$Agent.prototype.flash start!-//
/**
	flash() �޼���� ������� Flash Player ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method flash
	@return {Object} Flash Player ������ �����ϴ� ��ü.
	@filter desktop
	@remark Flash Player ������ �����ϴ� ��ü�� Flash Player ��ġ ���ο� ��ġ�� Flash Player�� ���� ������ �����Ѵ�. 	������ Flash Player�� ������ ��� �ִ� ��ü�� �Ӽ��� ������ ǥ�̴�.<br>
		<h5>Flash Player ���� ��ü �Ӽ�</h5>
		<table class="tbl_board">
			<caption class="hide">Flash Player ���� ��ü �Ӽ�</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">installed</td>
					<td>Boolean</td>
					<td class="txt">Flash Player ��ġ ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">version</td>
					<td>Number</td>
					<td class="txt">����ڰ� ����ϰ� �ִ� Flash Player�� ���� ������ �����Ѵ�. �Ǽ�(Float) ���·� ���� ������ �����ϸ�, Flash Player�� ��ġ���� ���� ��� -1�� �����Ѵ�. </td>
				</tr>
			</tbody>
		</table>
	@see http://www.adobe.com/products/flashplayer/ Flash Player ���� ������
	@example
		var oFlash = $Agent().flash();
		oFlash.installed  // �÷��� �÷��̾ ��ġ�ߴٸ� true
		oFlash.version  // �÷��� �÷��̾��� ����.
 */
nv.$Agent.prototype.flash = function() {
	//-@@$Agent.flash-@@//
	var info = {};
	var p    = this._navigator.plugins;
	var m    = this._navigator.mimeTypes;
	var f    = null;

	info.installed = false;
	info.version   = -1;
	
	if (!nv.$Jindo.isUndefined(p)&& p.length) {
		f = p["Shockwave Flash"];
		if (f) {
			info.installed = true;
			if (f.description) {
				info.version = parseFloat(f.description.match(/[0-9.]+/)[0]);
			}
		}

		if (p["Shockwave Flash 2.0"]) {
			info.installed = true;
			info.version   = 2;
		}
	} else if (!nv.$Jindo.isUndefined(m) && m.length) {
		f = m["application/x-shockwave-flash"];
		info.installed = (f && f.enabledPlugin);
	} else {
		try {
			info.version   = parseFloat(new ActiveXObject('ShockwaveFlash.ShockwaveFlash').GetVariable('$version').match(/(.\d?),/)[1]);
			info.installed = true;
		} catch(e) {}
	}

	this.flash = function() {
		return info;
	};
    /*
    ����ȣȯ�� ���� �ϴ� ���ܵд�.
     */
	this.info = this.flash;

	return info;
};
//-!nv.$Agent.prototype.flash end!-//

//-!nv.$Agent.prototype.silverlight start!-//
/**
	silverlight() �޼���� ������� �ǹ�����Ʈ(Silverlight) ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method silverlight
	@return {Object} �ǹ�����Ʈ ������ �����ϴ� ��ü.
	@filter desktop
	@remark �ǹ�����Ʈ ������ �����ϴ� ��ü�� �ǹ�����Ʈ ��ġ ���ο� ��ġ�� �ǹ�����Ʈ�� ���� ������ �����Ѵ�. ������ �ǹ�����Ʈ ������ ��� �ִ� ��ü�� �Ӽ��� ������ ǥ�̴�.<br>
		<h5>�ǹ�����Ʈ ���� ��ü �Ӽ�</h5>
		<table class="tbl_board">
			<caption class="hide">�ǹ�����Ʈ ���� ��ü �Ӽ�</caption>
			<thead>
				<tr>
					<th scope="col" style="width:15%">�̸�</th>
					<th scope="col" style="width:15%">Ÿ��</th>
					<th scope="col">����</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">installed</td>
					<td>Boolean</td>
					<td class="txt">�ǹ�����Ʈ ��ġ ���θ� �Ҹ��� ���·� �����Ѵ�.</td>
				</tr>
				<tr>
					<td class="txt bold">version</td>
					<td>Number</td>
					<td class="txt">����ڰ� ����ϰ� �ִ� �ǹ�����Ʈ�� ���� ������ �����Ѵ�. �Ǽ�(Float) ���·� ���� ������ �����ϸ�, �ǹ�����Ʈ�� ��ġ���� ���� ��� -1�� �����Ѵ�. </td>
				</tr>
			</tbody>
		</table>
	@see http://www.microsoft.com/silverlight �ǹ�����Ʈ ���� ������
	@example
		var oSilver = $Agent.silverlight();
		oSilver.installed  // Silverlight �÷��̾ ��ġ�ߴٸ� true
		oSilver.version  // Silverlight �÷��̾��� ����.
 */
nv.$Agent.prototype.silverlight = function() {
	//-@@$Agent.silverlight-@@//
	var info = new Object;
	var p    = this._navigator.plugins;
	var s    = null;

	info.installed = false;
	info.version   = -1;

	if (!nv.$Jindo.isUndefined(p) && p.length) {
		s = p["Silverlight Plug-In"];
		if (s) {
			info.installed = true;
			info.version = parseInt(s.description.split(".")[0],10);
			if (s.description == "1.0.30226.2") info.version = 2;
		}
	} else {
		try {
			s = new ActiveXObject("AgControl.AgControl");
			info.installed = true;
			if(s.isVersionSupported("3.0")){
				info.version = 3;
			}else if (s.isVersionSupported("2.0")) {
				info.version = 2;
			} else if (s.isVersionSupported("1.0")) {
				info.version = 1;
			}
		} catch(e) {}
	}

	this.silverlight = function() {
		return info;
	};

	return info;
};
//-!nv.$Agent.prototype.silverlight end!-//

/**
 	@fileOverview nv.$H() ��ü�� ������ �� �޼��带 ������ ����
	@name hash.js
	@author NAVER Ajax Platform
 */
//-!nv.$H start!-//
/**
 	nv.$H() ��ü�� Ű(key)�� ��(value)�� ���ҷ� ������ ������ �迭�� �ؽ�(Hash)�� �����ϰ�, �ؽø� �ٷ�� ���� ���� ���� ���� �޼��带 �����Ѵ�.
	
	@class nv.$H
	@keyword hash, �ؽ�
 */
/**
 	nv.$H() ��ü�� �����Ѵ�.
	
	@constructor
	@param {Hash+} oHashObject �ؽ÷� ���� ��ü.
	@example
		var h = $H({one:"first", two:"second", three:"third"});
 */
nv.$H = function(hashObject) {
	//-@@$H-@@//
	var cl = arguments.callee;
	if (hashObject instanceof cl) return hashObject;
	
	if (!(this instanceof cl)){
		try {
			nv.$Jindo._maxWarn(arguments.length, 1,"$H");
			return new cl(hashObject||{});
		} catch(e) {
			if (e instanceof TypeError) { return null; }
			throw e;
		}
	}
	
	var oArgs = g_checkVarType(arguments, {
		'4obj' : ['oObj:Hash+'],
		'4vod' : []
	},"$H");

	this._table = {};
	for(var k in hashObject) {
		if(hashObject.hasOwnProperty(k)){
			this._table[k] = hashObject[k];	
		}
	}
};
//-!nv.$H end!-//

//-!nv.$H.prototype.$value start!-//
/**
 	$value() �޼���� �ؽ�(Hash)�� ��ü�� ��ȯ�Ѵ�.
	
	@method $value
	@return {Object} �ؽð� ����� ��ü.
 */
nv.$H.prototype.$value = function() {
	//-@@$H.$value-@@//
	return this._table;
};
//-!nv.$H.prototype.$value end!-//

//-!nv.$H.prototype.$ start!-//
/**
 	$() �޼���� Ű(key)�� �ش��ϴ� ��(value)�� ��ȯ�Ѵ�.
	
	@method $
	@param {String+|Numeric} sKey �ؽ��� Ű.
	@return {Variant} Ű�� �ش��ϴ� ��.
	@example
		var woH = $H({one:"first", two:"second", three:"third"});
		
		// ���� ��ȯ�� ��
		var three = woH.$("three");
		// ��� : three = "third"
 */
/**
 	$() �޼���� Ű(key)�� ��(value)�� ������ ������ �����Ѵ�.
	
	@method $
	@syntax sKey, vValue
	@syntax oKeyAndValue
	@param {String+ | Numeric} sKey �ؽ��� Ű.
	@param {Variant} vValue ������ ��.
	@param {Hash+} oKeyAndValue key�� value�ε� ������Ʈ
	@return {this} �ν��Ͻ� �ڽ�
	@example
		var woH = $H({one:"first", two:"second"});
		
		// ���� ������ ��
		woH.$("three", "third");
		// ��� : woH => {one:"first", two:"second", three:"third"}
 */
nv.$H.prototype.$ = function(key, value) {
	//-@@$H.$-@@//
	var oArgs = g_checkVarType(arguments, {
		's4var' : [ nv.$Jindo._F('key:String+'), 'value:Variant' ],
		's4var2' : [ 'key:Numeric', 'value:Variant' ],
		'g4str' : [ 'key:String+' ],
		's4obj' : [ 'oObj:Hash+'],
		'g4num' : [ 'key:Numeric' ]
	},"$H#$");
	
	switch(oArgs+""){
		case "s4var":
		case "s4var2":
			this._table[key] = value;
			return this;
		case "s4obj":
			var obj = oArgs.oObj;
			for(var i in obj){
			    if(obj.hasOwnProperty(i)){
    				this._table[i] = obj[i];
			    }
			}
			return this;
		default:
			return this._table[key];
	}
	
};
//-!nv.$H.prototype.$ end!-//

//-!nv.$H.prototype.length start!-//
/**
 	length() �޼���� �ؽ� ��ü�� ũ�⸦ ��ȯ�Ѵ�.
	
	@method length
	@return {Numeric} �ؽ��� ũ��.
	@example
		var woH = $H({one:"first", two:"second"});
		woH.length(); // ��� : 2
 */
nv.$H.prototype.length = function() {
	//-@@$H.length-@@//
	var index = 0;
	var sortedIndex = this["__nv_sorted_index"];
	if(sortedIndex){
	    return sortedIndex.length;
	}else{
    	for(var k in this._table) {
    		if(this._table.hasOwnProperty(k)){
    			if (Object.prototype[k] !== undefined && Object.prototype[k] === this._table[k]) continue;
    			index++;
    		}
    	}
    
	}
	return index;
};
//-!nv.$H.prototype.length end!-//

//-!nv.$H.prototype.forEach start(nv.$H.Break,nv.$H.Continue)!-//
/**
 	forEach() �޼���� �ؽ��� ��� ���Ҹ� ��ȸ�ϸ鼭 �ݹ� �Լ��� �����Ѵ�. �̶� �ؽ� ��ü�� Ű�� �� �׸��� ���� �ؽ� ��ü�� �ݹ� �Լ��� �Ķ���ͷ� �Էµȴ�. nv.$A() ��ü�� forEach() �޼���� �����ϴ�. $H.Break()�� $H.Continue()�� ����� �� �ִ�.
	
	@method forEach
	@param {Function+} fCallback �ؽø� ��ȸ�ϸ鼭 ������ �ݹ� �Լ�. �ݹ� �Լ��� �Ķ���ͷ� key, value, object�� ���´�.<br>
		<ul class="disc">
			<li>value�� �ش� ������ ���̴�.</li>
			<li>key�� �ش� ������ Ű�̴�.</li>
			<li>object�� �ؽ� �� ��ü�� ����Ų��.</li>
		</ul>
	@param {Variant} [oThis] �ݹ� �Լ��� ��ü�� �޼����� �� �ݹ� �Լ� ���ο��� this Ű������ ���� ����(Execution Context)���� ����� ��ü.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$H#map
	@see nv.$H#filter
	@see nv.$A#forEach
	@example
		function printIt(value, key, object) {
		   document.write(key+" => "+value+" <br>");
		}
		$H({one:"first", two:"second", three:"third"}).forEach(printIt);
 */
nv.$H.prototype.forEach = function(callback, scopeObject) {
	//-@@$H.forEach-@@//
	var oArgs = g_checkVarType(arguments, {
		'4fun' : [ 'callback:Function+'],
		'4obj' : [ 'callback:Function+', "thisObject:Variant"]
	},"$H#forEach");
	var t = this._table;
	var h = this.constructor;
	var sortedIndex = this["__nv_sorted_index"];
	
	if(sortedIndex){
	    for(var i = 0, l = sortedIndex.length; i < l ; i++){
	        
	        try {
	            var k = sortedIndex[i];
                callback.call(scopeObject||this, t[k], k, t);
            } catch(e) {
                if (e instanceof h.Break) break;
                if (e instanceof h.Continue) continue;
                throw e;
            }
	    }
	}else{
    	for(var k in t) {
    		if (t.hasOwnProperty(k)) {
    			if (!t.propertyIsEnumerable(k)){
    			    continue;
    			}
    			try {
                    callback.call(scopeObject||this, t[k], k, t);
                } catch(e) {
                    if (e instanceof h.Break) break;
                    if (e instanceof h.Continue) continue;
                    throw e;
                }
    		}
    	}
	}
	
	return this;
};
//-!nv.$H.prototype.forEach end!-//

//-!nv.$H.prototype.filter start(nv.$H.prototype.forEach)!-//
/**
 	filter() �޼���� �ؽ��� ��� ���Ҹ� ��ȸ�ϸ鼭 �ݹ� �Լ��� �����ϰ� �ݹ� �Լ��� true ���� ��ȯ�ϴ� ���Ҹ� ��� ���ο� nv.$H() ��ü�� ��ȯ�Ѵ�. nv.$A() ��ü�� filter() �޼���� �����ϴ�. $H.Break()�� $H.Continue()�� ����� �� �ִ�.
	
	@method filter
	@param {Function+} fCallback �ؽø� ��ȸ�ϸ鼭 ������ �ݹ� �Լ�. �ݹ� �Լ��� Boolean ���·� ���� ��ȯ�ؾ� �Ѵ�. true ���� ��ȯ�ϴ� ���Ҵ� ���ο� �ؽ��� ���Ұ� �ȴ�. �ݹ� �Լ��� �Ķ���ͷ� value, key, object�� ���´�.<br>
		<ul class="disc">
			<li>value�� �ش� ������ ���̴�.</li>
			<li>key�� �ش� ������ Ű�̴�.</li>
			<li>object�� �ؽ� �� ��ü�� ����Ų��.</li>
		</ul>
	@param {Variant} [oThis] �ݹ� �Լ��� ��ü�� �޼����� �� �ݹ� �Լ� ���ο��� this Ű������ ���� ����(Execution Context) ����� ��ü.
	@return {nv.$H} �ݹ� �Լ��� ��ȯ ���� true�� ���ҷ� �̷���� ���ο� nv.$H() ��ü.
	@see nv.$H#forEach
	@see nv.$H#map
	@see nv.$A#filter
	@example
		var ht=$H({one:"first", two:"second", three:"third"})
		
		ht.filter(function(value, key, object){
			return value.length < 5;
		})
		
		// ���
		// one:"first", three:"third"
 */
nv.$H.prototype.filter = function(callback, thisObject) {
	//-@@$H.filter-@@//
	var oArgs = g_checkVarType(arguments, {
		'4fun' : [ 'callback:Function+'],
		'4obj' : [ 'callback:Function+', "thisObject:Variant"]
	},"$H#filter");
	var h = nv.$H();
	var t = this._table;
	var hCon = this.constructor;
	
	for(var k in t) {
		if (t.hasOwnProperty(k)) {
			if (!t.propertyIsEnumerable(k)) continue;
			try {
				if(callback.call(thisObject||this, t[k], k, t)){
					h.add(k,t[k]);
				}
			} catch(e) {
				if (e instanceof hCon.Break) break;
				if (e instanceof hCon.Continue) continue;
				throw e;
			}
		}
	}
	return h;
};
//-!nv.$H.prototype.filter end!-//

//-!nv.$H.prototype.map start(nv.$H.prototype.forEach)!-//
/**
 	map() �޼���� �ؽ��� ��� ���Ҹ� ��ȸ�ϸ鼭 �ݹ� �Լ��� �����ϰ� �ݹ� �Լ��� ���� ����� �迭�� ���ҿ� �����Ѵ�. nv.$A() ��ü�� map() �޼���� �����ϴ�. $H.Break()�� $H.Continue()�� ����� �� �ִ�.
	
	@method map
	@param {Function+} fCallback �ؽø� ��ȸ�ϸ鼭 ������ �ݹ� �Լ�. �ݹ� �Լ����� ��ȯ�ϴ� ���� �ش� ������ ������ �缳���Ѵ�. �ݹ� �Լ��� �Ķ���ͷ� value, key, object�� ���´�.<br>
		<ul class="disc">
			<li>value�� �ش� ������ ���̴�.</li>
			<li>key�� �ش� ������ Ű�̴�.</li>
			<li>object�� �ؽ� �� ��ü�� ����Ų��.</li>
		</ul>
	@param {Variant} [oThis] �ݹ� �Լ��� ��ü�� �޼����� �� �ݹ� �Լ� ���ο��� this Ű������ ���� ����(Execution Context) ����� ��ü.
	@return {nv.$H} �ݹ� �Լ��� ���� ����� �ݿ��� ���ο� nv.$H() ��ü.
	@see nv.$H#forEach
	@see nv.$H#filter
	@see nv.$H#map
	@example
		function callback(value, key, object) {
		   var r = key+"_"+value;
		   document.writeln (r + "<br />");
		   return r;
		}
		
		$H({one:"first", two:"second", three:"third"}).map(callback);
 */

nv.$H.prototype.map = function(callback, thisObject) {
	//-@@$H.map-@@//
	var oArgs = g_checkVarType(arguments, {
		'4fun' : [ 'callback:Function+'],
		'4obj' : [ 'callback:Function+', "thisObject:Variant"]
	},"$H#map");
	var h = nv.$H();
	var t = this._table;
	var hCon = this.constructor;
	
	for(var k in t) {
		if (t.hasOwnProperty(k)) {
			if (!t.propertyIsEnumerable(k)) continue;
			try {
				h.add(k,callback.call(thisObject||this, t[k], k, t));
			} catch(e) {
				if (e instanceof hCon.Break) break;
				if (e instanceof hCon.Continue){
					h.add(k,t[k]);
				}else{
					throw e;
				}
			}
		}
	}
	
	return h;
};
//-!nv.$H.prototype.map end!-//

//-!nv.$H.prototype.add start!-//
/**
 	add() �޼���� �ؽÿ� ���� �߰��Ѵ�. �Ķ���ͷ� ���� �߰��� Ű�� �����Ѵ�. ������ Ű�� �̹� ���� �ִٸ� ������ ������ �����Ѵ�.
	
	@method add
	@param {String+ | Numeric} sKey ���� �߰��ϰų� ������ Ű.
	@param {Variant} vValue �ش� Ű�� �߰��� ��.
	@return {this} ���� �߰��� �ν��Ͻ� �ڽ�
	@see nv.$H#remove
	@example
		var woH = $H();
		// Ű�� 'foo'�̰� ���� 'bar'�� ���Ҹ� �߰�
		woH.add('foo', 'bar');
		
		// Ű�� 'foo'�� ������ ���� 'bar2'�� ����
		woH.add('foo', 'bar2');
 */
nv.$H.prototype.add = function(key, value) {
	//-@@$H.add-@@//
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'key:String+',"value:Variant"],
		'4num' : [ 'key:Numeric',"value:Variant"]
	},"$H#add");
	var sortedIndex = this["__nv_sorted_index"];
    if(sortedIndex && this._table[key]==undefined ){
        this["__nv_sorted_index"].push(key);
    }
	this._table[key] = value;

	return this;
};
//-!nv.$H.prototype.add end!-//

//-!nv.$H.prototype.remove start!-//
/**
 	remove() �޼���� ������ Ű�� ���Ҹ� �����Ѵ�. �ش��ϴ� ���Ұ� ������ �ƹ� �ϵ� �������� �ʴ´�.
	
	@method remove
	@param {String+ | Numeric} sKey ������ ������ Ű.
	@return {Variant} ������ ��.
	@see nv.$H#add
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.remove ("two");
		// h�� �ؽ� ���̺��� {one:"first", three:"third"}
 */
nv.$H.prototype.remove = function(key) {
	//-@@$H.remove-@@//
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'key:String+'],
		'4num' : [ 'key:Numeric']
	},"$H#remove");
	
	if (this._table[key] === undefined) return null;
	var val = this._table[key];
	delete this._table[key];
	
	
	var sortedIndex = this["__nv_sorted_index"];
	if(sortedIndex){
    	var newSortedIndex = [];
    	for(var i = 0, l = sortedIndex.length ; i < l ; i++){
    	    if(sortedIndex[i] != key){
    	        newSortedIndex.push(sortedIndex[i]);
    	    }
    	}
    	this["__nv_sorted_index"] = newSortedIndex;
	}
	return val;
};
//-!nv.$H.prototype.remove end!-//

//-!nv.$H.prototype.search start!-//
/**
 	search() �޼���� �ؽÿ��� �Ķ���ͷ� ������ ���� ������ ������ Ű�� ��ȯ�Ѵ�.
	
	@method search
	@param {Variant} sValue �˻��� ��.
	@return {Variant} �ش� ���� ������ �ִ� ������ Ű(String). ������ ���� ���� ���Ұ� ���ٸ� false�� ��ȯ�Ѵ�.
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.search ("second"); // two
		h.search ("fist"); // false
 */
nv.$H.prototype.search = function(value) {
	//-@@$H.search-@@//
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'value:Variant']
	},"$H#search");
	var result = false;
	var t = this._table;

	for(var k in t) {
		if (t.hasOwnProperty(k)) {
			if (!t.propertyIsEnumerable(k)) continue;
			var v = t[k];
			if (v === value) {
				result = k;
				break;
			}			
		}
	}
	
	return result;
};
//-!nv.$H.prototype.search end!-//

//-!nv.$H.prototype.hasKey start!-//
/**
 	hasKey() �޼���� �ؽÿ� �Ķ���ͷ� �Է��� Ű�� �ִ��� Ȯ���Ѵ�.
	
	@method hasKey
	@param {String+|Numeric} sKey �˻��� Ű.
	@return {Boolean} Ű�� ���� ����. �����ϸ� true ������ false�� ��ȯ�Ѵ�.
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.hasKey("four"); // false
		h.hasKey("one"); // true
 */
nv.$H.prototype.hasKey = function(key) {
	//-@@$H.hasKey-@@//
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'key:String+'],
		'4num' : [ 'key:Numeric']
	},"$H#hasKey");
	return this._table[key] !== undefined;
};
//-!nv.$H.prototype.hasKey end!-//

//-!nv.$H.prototype.hasValue start(nv.$H.prototype.search)!-//
/**
 	hasValue() �޼���� �ؽÿ� �Ķ���ͷη� �Է��� ���� �ִ��� Ȯ���Ѵ�.
	
	@method hasValue
	@param {Variant} vValue �ؽÿ��� �˻��� ��.
	@return {Boolean} ���� ���� ����. �����ϸ� true ������ false�� ��ȯ�Ѵ�.
 */
nv.$H.prototype.hasValue = function(value) {
	//-@@$H.hasValue-@@//
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'value:Variant']
	},"$H#hasValue");
	return (this.search(value) !== false);
};
//-!nv.$H.prototype.hasValue end!-//



//-!nv.$H.prototype.sort start(nv.$H.prototype.search)!-//
nv._p_.defaultSort = function(oArgs,that,type){
    var aSorted = [];
    var fpSort = oArgs.fpSort;
    for(var k in that._table) {
        if(that._table.hasOwnProperty(k)){
          (function(k,v){
            aSorted.push({
                "key" : k,
                "val" : v
            });
          })(k,that._table[k]);
        }
    }
    
    if(oArgs+"" === "vo"){
        fpSort = function (a,b){
            return a === b ? 0 : a > b ? 1 : -1;
        };
    }
    
    aSorted.sort(function(beforeVal,afterVal){
        return fpSort.call(that, beforeVal[type], afterVal[type]);
    });
    
    var sortedKey = [];
    for(var i = 0, l = aSorted.length; i < l; i++){
        sortedKey.push(aSorted[i].key);
    }
    
    return sortedKey;
};
/**
 	sort() �޼���� ���� �������� �ؽ��� ���Ҹ� �������� �����Ѵ�.
	�ٸ�, ���� ���� ����Ǵ� ���� �ƴ϶� $H#forEach�� ����ؾ�����
	���ĵ� ����� ����� �� �ִ�.
	
	@method sort
	@param {Function} [sortFunc] ���� ������ �� �ֵ��� �Լ��� ���� �� �ִ�.
		@param {Variant} [sortFunc.preVal] ���� ��
		@param {Variant} [sortFunc.foreVal] ���� ��
		
	@return {this} ���Ҹ� ������ �ν��Ͻ� �ڽ�
	@see nv.$H#ksort
	@see nv.$H#forEach
	@example
		var h = $H({one:"�ϳ�", two:"��", three:"��"});
		h.sort ();
		h.forEach(function(v){
			//��
			//��
			//�ϳ�
		});
	@example
		var h = $H({one:"�ϳ�", two:"��", three:"��"});
		h.sort(function(val, val2){
			return val === val2 ? 0 : val < val2 ? 1 : -1;
		});
		h.forEach(function(v){
			//�ϳ�
			//��
			//��
		});
 */

nv.$H.prototype.sort = function(fpSort) {
	//-@@$H.sort-@@//
	var oArgs = g_checkVarType(arguments, {
	    'vo'  : [],
        '4fp' : [ 'fpSort:Function+']
    },"$H#sort");
    
	this["__nv_sorted_index"] = nv._p_.defaultSort(oArgs,this,"val"); 
	return this;
};
//-!nv.$H.prototype.sort end!-//

//-!nv.$H.prototype.ksort start(nv.$H.prototype.keys)!-//
/**
 	ksort() �޼���� Ű�� �������� �ؽ��� ���Ҹ� �������� �����Ѵ�.
	�ٸ�, ���� ���� ����Ǵ� ���� �ƴ϶� $H#forEach�� ����ؾ�����
	���ĵ� ����� ����� �� �ִ�.
	
	@method ksort
	@param {Function} [sortFunc] ���� ������ �� �ֵ��� �Լ��� ���� �� �ִ�.
		@param {Variant} [sortFunc.preKey] ���� Ű
		@param {Variant} [sortFunc.foreKey] ���� Ű
	@return {this} ���Ҹ� ������ �ν��Ͻ� �ڽ�
	@see nv.$H#sort
	@see nv.$H#forEach
	@example
		var h = $H({one:"�ϳ�", two:"��", three:"��"});
		h.ksort ();
		h.forEach(function(v){
			//�ϳ�
			//��
			//��
		});
	@example
		var h = $H({one:"�ϳ�", two:"��", three:"��"});
		h.ksort (function(key, key2){
			return key === key2 ? 0 : key < key2 ? 1 : -1;
		});
		h.forEach(function(v){
			//��
			//��
			//�ϳ�
		});
 */
nv.$H.prototype.ksort = function(fpSort) {
	//-@@$H.ksort-@@//
	var oArgs = g_checkVarType(arguments, {
        'vo'  : [],
        '4fp' : [ 'fpSort:Function+']
    },"$H#ksort");
    
    this["__nv_sorted_index"] = nv._p_.defaultSort(oArgs,this,"key");
	return this;
};
//-!nv.$H.prototype.ksort end!-//

//-!nv.$H.prototype.keys start!-//
/**
 	keys() �޼���� �ؽ��� Ű�� �迭�� ��ȯ�Ѵ�.
	
	@method keys
	@return {Array} �ؽ� Ű�� �迭.
	@see nv.$H#values
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.keys ();
		// ["one", "two", "three"]
 */
nv.$H.prototype.keys = function() {
	//-@@$H.keys-@@//
	var keys = this["__nv_sorted_index"];
	
	if(!keys){
	    keys = [];
    	for(var k in this._table) {
    		if(this._table.hasOwnProperty(k))
    			keys.push(k);
    	}
	}

	return keys;
};
//-!nv.$H.prototype.keys end!-//

//-!nv.$H.prototype.values start!-//
/**
 	values() �޼���� �ؽ��� ���� �迭�� ��ȯ�Ѵ�.
	
	@method values
	@return {Array} �ؽ� ���� �迭.
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.values();
		// ["first", "second", "third"]
 */
nv.$H.prototype.values = function() {
	//-@@$H.values-@@//
	var values = [];
	for(var k in this._table) {
		if(this._table.hasOwnProperty(k))
			values[values.length] = this._table[k];
	}

	return values;
};
//-!nv.$H.prototype.values end!-//

//-!nv.$H.prototype.toQueryString start!-//
/**
 	toQueryString() �޼���� �ؽø� ���� ��Ʈ��(Query String) ���·� �����.
	
	@method toQueryString
	@return {String} �ؽø� ��ȯ�� ���� ��Ʈ��.
	@see http://en.wikipedia.org/wiki/Querystring Query String - Wikipedia
	@example
		var h = $H({one:"first", two:"second", three:"third"});
		h.toQueryString();
		// "one=first&two=second&three=third"
 */
nv.$H.prototype.toQueryString = function() {
	//-@@$H.toQueryString-@@//
	var buf = [], val = null, idx = 0;

	for(var k in this._table) {
		if(this._table.hasOwnProperty(k)) {
			val = this._table[k];

			if(nv.$Jindo.isArray(val)) {
				for(var i=0; i < val.length; i++) {
					buf[buf.length] = encodeURIComponent(k)+"[]="+encodeURIComponent(val[i]+"");
				}
			} else {
				buf[buf.length] = encodeURIComponent(k)+"="+encodeURIComponent(this._table[k]+"");
			}
		}
	}
	
	return buf.join("&");
};
//-!nv.$H.prototype.toQueryString end!-//

//-!nv.$H.prototype.empty start!-//
/**
 	empty() �޼���� �ؽø� ����.
	
	@method empty
	@return {this} ����� �ν��Ͻ� �ڽ�
	@example
		var hash = $H({a:1, b:2, c:3});
		// hash => {a:1, b:2, c:3}
		
		hash.empty();
		// hash => {}
 */
nv.$H.prototype.empty = function() {
	//-@@$H.empty-@@//
	this._table = {};
	delete this["__nv_sorted_index"];
	
	return this;
};
//-!nv.$H.prototype.empty end!-//

//-!nv.$H.Break start!-//
/**
 	Break() �޼���� forEach(), filter(), map() �޼����� ������ �ߴ��Ѵ�. ���������δ� ������ ���ܸ� �߻���Ű�� �����̹Ƿ�, try - catch �������� �� �޼��带 �����ϸ� ���������� �������� ���� �� �ִ�.
	
	@method Break
	@static
	@see nv.$H#Continue
	@see nv.$H#forEach
	@see nv.$H#filter
	@see nv.$H#map
	@example
		$H({a:1, b:2, c:3}).forEach(function(v,k,o) {
		  ...
		  if (k == "b") $H.Break();
		   ...
		});
 */
nv.$H.Break = nv.$Jindo.Break;
//-!nv.$H.Break end!-//

//-!nv.$H.Continue start!-//
/**
 	Continue() �޼���� forEach(), filter(), map() �޼����� �������� ������ ����� �������� �ʰ� ���� ������ �ǳʶڴ�. ���������δ� ������ ���ܸ� �߻���Ű�� �����̹Ƿ�, try - catch �������� �� �޼��带 �����ϸ� ���������� �������� ���� �� �ִ�.
	
	@method Continue
	@static
	@see nv.$H#Break
	@see nv.$H#forEach
	@see nv.$H#filter
	@see nv.$H#map
	@example
		$H({a:1, b:2, c:3}).forEach(function(v,k,o) {
		   ...
		   if (v % 2 == 0) $H.Continue();
		   ...
		});
 */
nv.$H.Continue  = nv.$Jindo.Continue;
//-!nv.$H.Continue end!-//


/**
 	@fileOverview nv.$Fn() ��ü�� ???���� �� �޼��带 ������ ����
	@name function.js 
	@author NAVER Ajax Platform
 */
//-!nv.$Fn start!-//
/**
 	nv.$Fn() ��ü�� Function ��ü�� ����(wrapping)�Ͽ� �Լ��� ���õ� Ȯ�� ����� �����Ѵ�.
	
	@class nv.$Fn
	@keyword function, �Լ�
 */
/**
 	nv.$Fn() ��ü()�� �����Ѵ�. �������� �Ķ���ͷ� Ư�� �Լ��� ������ �� �ִ�. �� ��, �Լ��� �Բ� this Ű���带 ��Ȳ�� �°� ����� �� �ֵ��� ���� ����(Execution Context)�� �Բ� ������ �� �ִ�. ���� �������� �Ķ���ͷ� ������ �Լ��� �Ķ���Ϳ� ��ü�� ���� �Է��Ͽ� nv.$Fn() ��ü�� ������ �� �ִ�.
	
	@constructor
	@syntax fpFunction, vExeContext
	@syntax sFuncArgs, sFuncBody
	@param {Function+} fpFunction ������ �Լ�
	@param {Variant} [vExeContext] �Լ��� ���� ������ �� ��ü
	@param {String} sFuncArgs �Լ��� �Ķ���͸� ��Ÿ���� ���ڿ�
	@param {String} sFuncBody �Լ��� ��ü�� ��Ÿ���� ���ڿ�
	@return {nv.$Fn} nv.$Fn() ��ü
	@see nv.$Fn#toFunction
	@example
		func : function() {
		       // code here
		}
		
		var fn = $Fn(func, this);
	@example
		var someObject = {
		    func : function() {
		       // code here
		   }
		}
		
		var fn = $Fn(someObject.func, someObject);
	@example
		var fn = $Fn("a, b", "return a + b;");
		var result = fn.$value()(1, 2) // result = 3;
		
		// fn�� �Լ� ���ͷ��� function(a, b){ return a + b;}�� ������ �Լ��� �����Ѵ�.
 */
nv.$Fn = function(func, thisObject) {
	//-@@$Fn-@@//
	var cl = arguments.callee;
	if (func instanceof cl) return func;

	if (!(this instanceof cl)){
		try {
			nv.$Jindo._maxWarn(arguments.length, 2,"$Fn");
			return new cl(func, thisObject);
		} catch(e) {
			if (e instanceof TypeError) { return null; }
			throw e;
		}
	}	

	var oArgs = g_checkVarType(arguments, {
		'4fun' : ['func:Function+'],
		'4fun2' : ['func:Function+', "thisObject:Variant"],
		'4str' : ['func:String+', "thisObject:String+"]
	},"$Fn");

	this._tmpElm = null;
	this._key    = null;
	
	switch(oArgs+""){
		case "4str":
			this._func = eval("false||function("+func+"){"+thisObject+"}");
			break;
		case "4fun":
		case "4fun2":
			this._func = func;
			this._this = thisObject;
			
	}

};

/**
 * @ignore 
 */
nv.$Fn._commonPram = function(oPram,sMethod){
	return g_checkVarType(oPram, {
		'4ele' : ['eElement:Element+',"sEvent:String+"],
		'4ele2' : ['eElement:Element+',"sEvent:String+","bUseCapture:Boolean"],
		'4str' : ['eElement:String+',"sEvent:String+"],
		'4str2' : ['eElement:String+',"sEvent:String+","bUseCapture:Boolean"],
		'4arr' : ['aElement:Array+',"sEvent:String+"],
		'4arr2' : ['aElement:Array+',"sEvent:String+","bUseCapture:Boolean"],
		'4doc' : ['eElement:Document+',"sEvent:String+"],
		'4win' : ['eElement:Window+',"sEvent:String+"],
		'4doc2' : ['eElement:Document+',"sEvent:String+","bUseCapture:Boolean"],
		'4win2' : ['eElement:Window+',"sEvent:String+","bUseCapture:Boolean"]
	},sMethod);
};
//-!nv.$Fn end!-//

//-!nv.$Fn.prototype.$value start!-//
/**
 	$value() �޼���� ���� Function ��ü�� ��ȯ???��.
	
	@method $value
	@return {Function} ���� Function ��ü
	@example
		func : function() {
			// code here
		}
		
		var fn = $Fn(func, this);
		fn.$value(); // ������ �Լ��� ���ϵȴ�.
 */
nv.$Fn.prototype.$value = function() {
	//-@@$Fn.$value-@@//
	return this._func;
};
//-!nv.$Fn.prototype.$value end!-//

//-!nv.$Fn.prototype.bind start!-//
/**
 	bind() �޼���� �����ڰ� ������ ��ü�� �޼���� �����ϵ��� ���� Function ��ü�� ��ȯ�Ѵ�. �̶� �ش� �޼����� ���� ����(Execution Context)�� ������ ��ü�� �����ȴ�.
	
	@method bind
	@param {Variant} [vParameter*] ������ �Լ��� �⺻������ �Է��� ù~N ��° �Ķ����.
	@return {Function} ���� ������ �޼���� ���� Function ��ü
	@see nv.$Fn
	@see nv.$Class
	@example
		var sName = "OUT";
		var oThis = {
		    sName : "IN"
		};
		
		function getName() {
		    return this.sName;
		}
		
		oThis.getName = $Fn(getName, oThis).bind();
		
		alert( getName() );       	  //  OUT
		alert( oThis.getName() ); //   IN
	@example
		 // ���ε��� �޼��忡 �μ��� �Է��� ���
		var b = $Fn(function(one, two, three){
			console.log(one, two, three);
		}).bind(true);
		
		b();	// true, undefined, undefined
		b(false);	// true, false, undefined
		b(false, "1234");	// true, false, "1234"
	@example
		// �Լ��� �̸� �����ϰ� ���߿� ����� �� �Լ����� �����ϴ� ���� �ش� �Լ��� 
		// ������ ���� ���� �ƴ϶� �Լ� ���� ������ ���� ���ǹǷ� �̶� bind() �޼��带 �̿��Ѵ�.
		for(var i=0; i<2;i++){
			aTmp[i] = function(){alert(i);}
		}
		
		for(var n=0; n<2;n++){
			aTmp[n](); // ���� 2�� �ι� alert�ȴ�.
		}
		
		for(var i=0; i<2;i++){
		aTmp[i] = $Fn(function(nTest){alert(nTest);}, this).bind(i);
		}
		
		for(var n=0; n<2;n++){
			aTmp[n](); // ���� 0, 1�� alert�ȴ�.
		}
	@example
		//Ŭ������ ������ �� �Լ��� �Ķ���ͷ� ����ϸ�, scope�� ���߱� ���� bind() �޼��带 ����Ѵ�.
		var MyClass = $Class({
			fFunc : null,
			$init : function(func){
				this.fFunc = func;
		
				this.testFunc();
			},
			testFunc : function(){
				this.fFunc();
			}
		})
		var MainClass = $Class({
			$init : function(){
				var oMyClass1 = new MyClass(this.func1);
				var oMyClass2 = new MyClass($Fn(this.func2, this).bind());
			},
			func1 : function(){
				alert(this);// this�� MyClass �� �ǹ��Ѵ�.
			},
			func2 : function(){
				alert(this);// this�� MainClass �� �ǹ��Ѵ�.
			}
		})
		function init(){
			var a = new MainClass();
		}
*/
nv.$Fn.prototype.bind = function() {
	//-@@$Fn.bind-@@//
	var a = nv._p_._toArray(arguments);
	var f = this._func;
	var t = this._this||this;
	var b;
	if(f.bind){
	    a.unshift(t);
	    b = Function.prototype.bind.apply(f,a);
	}else{
	    
    	b = function() {
    		var args = nv._p_._toArray(arguments);
    		// fix opera concat bug
    		if (a.length) args = a.concat(args);
    
    		return f.apply(t, args);
    	};
	}
	return b;
};
//-!nv.$Fn.prototype.bind end!-//

//-!nv.$Fn.prototype.attach start(nv.$Fn.prototype.bind, nv.$Element.prototype.attach, nv.$Element.prototype.detach)!-//
/**
 {{attach}}
 */
nv.$Fn.prototype.attach = function(oElement, sEvent, bUseCapture) {
	//-@@$Fn.attach-@@//
	var oArgs = nv.$Fn._commonPram(arguments,"$Fn#attach");
	var fn = null, l, ev = sEvent, el = oElement, ua = nv._p_._j_ag;

	if (bUseCapture !== true) {
		bUseCapture = false;
	}

	this._bUseCapture = bUseCapture;

	switch(oArgs+""){
		case "4arr":
		case "4arr2":
			var el = oArgs.aElement;
			var ev = oArgs.sEvent;
			for(var i=0, l= el.length; i < l; i++) this.attach(el[i], ev, !!bUseCapture);
			return this;
	}
	fn = this._bind = this._bind?this._bind:this.bind();
	nv.$Element(el).attach(ev,fn);

	return this;
};
//-!nv.$Fn.prototype.attach end!-//

//-!nv.$Fn.prototype.detach start!-//
/**
 {{detach}}
 */
nv.$Fn.prototype.detach = function(oElement, sEvent, bUseCapture) {
	//-@@$Fn.detach-@@//
	var oArgs = nv.$Fn._commonPram(arguments,"$Fn#detach");

	var fn = null, l, el = oElement, ev = sEvent, ua = nv._p_._j_ag;

	switch(oArgs+""){
		case "4arr":
		case "4arr2":
			var el = oArgs.aElement;
			var ev = oArgs.sEvent;
			for(var i=0, l= el.length; i < l; i++) this.detach(el[i], ev, !!bUseCapture);
			return this;

	}
	fn = this._bind = this._bind?this._bind:this.bind();
	nv.$Element(oArgs.eElement).detach(oArgs.sEvent, fn);

	return this;
};
//-!nv.$Fn.prototype.detach end!-//

//-!nv.$Fn.prototype.delay start(nv.$Fn.prototype.bind)!-//
/**
 	delay() �޼���� ������ �Լ��� ������ �ð� ���Ŀ� ȣ���Ѵ�.
	
	@method delay
	@param {Numeric} nSec �Լ��� ȣ���� ������ ����� �ð�(�� ����).
	@param {Array+} [aArgs] �Լ��� ȣ���� �� ����� �Ķ���͸� ���� �迭.
	@return {nv.$Fn} ������ nv.$Fn() ��ü.
	@see nv.$Fn#bind
	@see nv.$Fn#setInterval
	@example
		function func(a, b) {
			alert(a + b);
		}
		
		$Fn(func).delay(5, [3, 5]); // 5�� ���Ŀ� 3, 5 ���� �Ű������� �ϴ� �Լ� func�� ȣ���Ѵ�.
 */
nv.$Fn.prototype.delay = function(nSec, args) {
	//-@@$Fn.delay-@@//
	var oArgs = g_checkVarType(arguments, {
		'4num' : ['nSec:Numeric'],
		'4arr' : ['nSec:Numeric','args:Array+']
	},"$Fn#delay");
	switch(oArgs+""){
		case "4num":
			args = args || [];
			break;
		case "4arr":
			args = oArgs.args;
			
	}
	this._delayKey = setTimeout(this.bind.apply(this, args), nSec*1000);
	return this;
};
//-!nv.$Fn.prototype.delay end!-//

//-!nv.$Fn.prototype.setInterval start(nv.$Fn.prototype.bind)!-//
/**
 	setInterval() �޼���� ������ �Լ��� ������ �ð� ���ݸ��� ȣ���Ѵ�.
	
	@method setInterval
	@param {Numeric} nSec �Լ��� ȣ���� �ð� ����(�� ����).
	@param {Array+} [aArgs] �Լ��� ȣ���� �� ����� �Ķ���͸� ���� �迭.
	@return {nv.$Fn} ������ nv.$Fn() ��ü.
	@see nv.$Fn#bind
	@see nv.$Fn#delay
	@example
		function func(a, b) {
			alert(a + b);
		}
		
		$Fn(func).setInterval(5, [3, 5]); // 5�� �������� 3, 5 ���� �Ű������� �ϴ� �Լ� func�� ȣ���Ѵ�.
 */
nv.$Fn.prototype.setInterval = function(nSec, args) {
	//-@@$Fn.setInterval-@@//
	//-@@$Fn.repeat-@@//
	var oArgs = g_checkVarType(arguments, {
		'4num' : ['nSec:Numeric'],
		'4arr' : ['nSec:Numeric','args:Array+']
	},"$Fn#setInterval");
	switch(oArgs+""){
		case "4num":
			args = args || [];
			break;
		case "4arr":
			args = oArgs.args;
			
	}
	this._repeatKey = setInterval(this.bind.apply(this, args), nSec*1000);
	return this;
};
//-!nv.$Fn.prototype.setInterval end!-//

//-!nv.$Fn.prototype.repeat start(nv.$Fn.prototype.setInterval)!-//
/**
 	repeat() �޼���� setInterval() �޼���� �����ϴ�.
	
	@method repeat
	@param {Numeric} nSec �Լ��� ȣ���� �ð� ����(�� ����).
	@param {Array+} [aArgs] �Լ��� ȣ���� �� ����� �Ķ����??? ���� �迭.
	@return {nv.$Fn} ������ nv.$Fn() ��ü.
	@see nv.$Fn#setInterval
	@see nv.$Fn#bind
	@see nv.$Fn#delay
	@example
		function func(a, b) {
			alert(a + b);
		}
		
		$Fn(func).repeat(5, [3, 5]); // 5�� �������� 3, 5 ���� �Ű������� �ϴ� �Լ� func�� ȣ���Ѵ�.
 */
nv.$Fn.prototype.repeat = nv.$Fn.prototype.setInterval;
//-!nv.$Fn.prototype.repeat end!-//

//-!nv.$Fn.prototype.stopDelay start!-//
/**
 	stopDelay() �޼���� delay() �޼���� ������ �Լ� ȣ���� ������ �� ����Ѵ�.
	
	@method stopDelay
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Fn#delay
	@example
		function func(a, b) {
			alert(a + b);
		}
		
		var fpDelay = $Fn(func);
		fpDelay.delay(5, [3, 5]);
		fpDelay.stopDelay();
 */
nv.$Fn.prototype.stopDelay = function(){
	//-@@$Fn.stopDelay-@@//
	if(this._delayKey !== undefined){
		window.clearTimeout(this._delayKey);
		delete this._delayKey;
	}
	return this;
};
//-!nv.$Fn.prototype.stopDelay end!-//

//-!nv.$Fn.prototype.stopRepeat start!-//
/**
 	stopRepeat() �޼���� repeat() �޼���� ������ �Լ� ȣ���� ���� �� ����Ѵ�.
	
	@method stopRepeat
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Fn#repeat
	@example
		function func(a, b) {
			alert(a + b);
		}
		
		var fpDelay = $Fn(func);
		fpDelay.repeat(5, [3, 5]);
		fpDelay.stopRepeat();
 */
nv.$Fn.prototype.stopRepeat = function(){
	//-@@$Fn.stopRepeat-@@//
	if(this._repeatKey !== undefined){
		window.clearInterval(this._repeatKey);
		delete this._repeatKey;
	}
	return this;
};
//-!nv.$Fn.prototype.stopRepeat end!-//

/**
 	@fileOverview nv.$Event() ��ü�� ������ �� �޼��带 ������ ����
	@name event.js
	@author NAVER Ajax Platform
 */
//-!nv.$Event start!-//
/**
 	nv.$Event() ��ü�� Event ��ü�� �����Ͽ� �̺�Ʈ ó���� ���õ� Ȯ�� ����� �����Ѵ�. ����ڴ� nv.$Event() ��ü�� ����Ͽ� �߻��� �̺�Ʈ�� ���� ������ �ľ��ϰų� ������ ������ �� �ִ�.
	
	@class nv.$Event
	@keyword event, �̺�Ʈ
 */
/**
 	Event ��ü�� ������ nv.$Event() ��ü�� �����Ѵ�.
	
	@constructor
	@param {Event} event Event ��ü.
 */
/**
 	�̺�Ʈ�� ����
	
	@property type
	@type String
 */
/**
 {{element}}
 */
/**
 	�̺�Ʈ�� �߻��� ������Ʈ
	
	@property srcElement
	@type Element
 */
/**
 	�̺�Ʈ�� ���ǵ� ������Ʈ
	
	@property currentElement
	@type Element
 */
/**
 	�̺�Ʈ�� ���� ������Ʈ
	
	@property relatedElement
	@type Element
 */
/**
 	delegate�� ����� ��� delegate�� ������Ʈ
	
	@property delegatedElement
	@type Element
	@example
		<div id="sample">
			<ul>
					<li><a href="#">1</a></li>
					<li>2</li>
			</ul>
		</div>
		$Element("sample").delegate("click","li",function(e){
			//li �ؿ� a�� Ŭ���� ���.
			e.srcElement -> a
			e.currentElement -> div#sample
			e.delegatedElement -> li
		});
 */
nv.$Event = (function(isMobile) {
	if(isMobile){
		return function(e){
			//-@@$Event-@@//
			var cl = arguments.callee;
			if (e instanceof cl) return e;
			if (!(this instanceof cl)) return new cl(e);
		
			this._event = this._posEvent = e;
			this._globalEvent = window.event;
			this.type = e.type.toLowerCase();
			if (this.type == "dommousescroll") {
				this.type = "mousewheel";
			} else if (this.type == "domcontentloaded") {
				this.type = "domready";
			}
			this.realType = this.type;
			
			this.isTouch = false;
			if(this.type.indexOf("touch") > -1){
				this._posEvent = e.changedTouches[0];
				this.isTouch = true;
			}
		
			this.canceled = false;
		
			this.srcElement = this.element = e.target || e.srcElement;
			this.currentElement = e.currentTarget;
			this.relatedElement = null;
			this.delegatedElement = null;
		
			if (!nv.$Jindo.isUndefined(e.relatedTarget)) {
				this.relatedElement = e.relatedTarget;
			} else if(e.fromElement && e.toElement) {
				this.relatedElement = e[(this.type=="mouseout")?"toElement":"fromElement"];
			}
		};
	}else{
		return function(e){
			//-@@$Event-@@//
			var cl = arguments.callee;
			if (e instanceof cl) return e;
			if (!(this instanceof cl)) return new cl(e);
		
			if (e === undefined) e = window.event;
			if (e === window.event && document.createEventObject) e = document.createEventObject(e);
		
		
			this.isTouch = false;
			this._event = this._posEvent = e;
			this._globalEvent = window.event;
		
			this.type = e.type.toLowerCase();
			if (this.type == "dommousescroll") {
				this.type = "mousewheel";
			} else if (this.type == "domcontentloaded") {
				this.type = "domready";
			}
		    this.realType = this.type;
			this.canceled = false;
		
			this.srcElement = this.element = e.target || e.srcElement;
			this.currentElement = e.currentTarget;
			this.relatedElement = null;
			this.delegatedElement = null;
		  
			if (e.relatedTarget !== undefined) {
				this.relatedElement = e.relatedTarget;
			} else if(e.fromElement && e.toElement) {
				this.relatedElement = e[(this.type=="mouseout")?"toElement":"fromElement"];
			}
		};
	}
})(nv._p_._JINDO_IS_MO);

//-!nv.$Event end!-//

/**
 	hook() �޼���� �̺�Ʈ ���� ��ȸ�Ѵ�.
	@method hook
	@syntax vName
	@static
	@param {String+} vName �̺�Ʈ��(String)
	@remark 2.5.0���� ��밡���ϴ�.
	@return {Variant} �̺�Ʈ�� ��Ÿ���� �� Ȥ�� �Լ�.
	@example
		$Event.hook("pointerDown");
		//MsPointerDown
 	hook() �޼���� �����ڰ� �̺�Ʈ�� ����� �������� �ش� �̺�Ʈ�� ������ �� �����Ͽ� ����Ѵ�.
	@method hook
	@syntax vName, vValue
	@syntax oList
	@static
	@param {String+} vName �̺�Ʈ��(String)
	@param {Variant} vValue ������ �̺�Ʈ��(String|Function)
	@param {Hash+} oList �ϳ� �̻��� �̺�Ʈ ��� ���� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@remark 2.5.0���� ��밡���ϴ�.
	@return {$Event} $Event
	
	
	@example
		$Event.hook("pointerDown","MsPointerDown");
		
		$Element("some").attach("pointerDown",function(){});
		//�����ڰ� hook���� ����ϸ� ������ �̺�Ʈ�� �Ҵ��� �� �̸��� �����Ѵ�.
		//pointerDown -> MsPointerDown
	@example
		//�Լ��� �Ҵ��� �� �ִ�.
		$Event.hook("pointerDown",function(){
			if(isWindow8&&isIE){
				return "MsPointerDown";
			}else if(isMobile){
				return "touchdown";
			}else{
				return "mousedown";
			}
		});
		
		$Element("some").attach("pointerDown",function(){});
		//������8�̰� IE10�� ���� MsPointerDown	
		//������� ���� touchdown	
		//��Ÿ�� mousedown
 */


//-!nv.$Event.nv._p_.customEvent start!-//
/**
 {{nv._p_.customEvent}}
 */

nv._p_.customEvent = {};
nv._p_.customEventStore = {};
nv._p_.normalCustomEvent = {};

nv._p_.hasCustomEvent = function(sName){
    return !!(nv._p_.getCustomEvent(sName)||nv._p_.normalCustomEvent[sName]);
};

nv._p_.getCustomEvent = function(sName){
    return nv._p_.customEvent[sName];
};

nv._p_.addCustomEventListener = function(eEle, sElementId, sEvent, vFilter,oCustomInstance){
    if(!nv._p_.customEventStore[sElementId]){
        nv._p_.customEventStore[sElementId] = {};
        nv._p_.customEventStore[sElementId].ele = eEle;
    }
    if(!nv._p_.customEventStore[sElementId][sEvent]){
        nv._p_.customEventStore[sElementId][sEvent] = {};
    }
    if(!nv._p_.customEventStore[sElementId][sEvent][vFilter]){
        nv._p_.customEventStore[sElementId][sEvent][vFilter] = {
            "custom" : oCustomInstance
        };
    }
};

nv._p_.setCustomEventListener = function(sElementId, sEvent, vFilter, aNative, aWrap){
    nv._p_.customEventStore[sElementId][sEvent][vFilter].real_listener = aNative;
    nv._p_.customEventStore[sElementId][sEvent][vFilter].wrap_listener = aWrap;
};

nv._p_.getCustomEventListener = function(sElementId, sEvent, vFilter){
    var store = nv._p_.customEventStore[sElementId];
    if(store&&store[sEvent]&&store[sEvent][vFilter]){
        return store[sEvent][vFilter];
    }
    return {};
};
 
nv._p_.getNormalEventListener = function(sElementId, sEvent, vFilter){
    var store = nv._p_.normalCustomEvent[sEvent];
    if(store&&store[sElementId]&&store[sElementId][vFilter]){
        return store[sElementId][vFilter];
    }
    return {};
};

nv._p_.hasCustomEventListener = function(sElementId, sEvent, vFilter){
    var store = nv._p_.customEventStore[sElementId];
    if(store&&store[sEvent]&&store[sEvent][vFilter]){
        return true;
    }
    return false;
};

//-!nv.$Event.customEvent start!-//
nv.$Event.customEvent = function(sName, oEvent) {
    var oArgs = g_checkVarType(arguments, {
        's4str' : [ 'sName:String+'],
        's4obj' : [ 'sName:String+', "oEvent:Hash+"]
    },"$Event.customEvent");

    
    switch(oArgs+""){
        case "s4str":
            if(nv._p_.hasCustomEvent(sName)){
                throw new nv.$Error("The Custom Event Name have to unique.");
            }else{
                nv._p_.normalCustomEvent[sName] = {};
            }

            return this;
        case "s4obj":
            if(nv._p_.hasCustomEvent(sName)){
                throw new nv.$Error("The Custom Event Name have to unique.");
            }else{
                nv._p_.normalCustomEvent[sName] = {};
                nv._p_.customEvent[sName] = function(){
                    this.name = sName;
                    this.real_listener = [];
                    this.wrap_listener = [];
                };
                var _proto = nv._p_.customEvent[sName].prototype;
                _proto.events = [];
                for(var i in oEvent){
                    _proto[i] = oEvent[i];
                    _proto.events.push(i);
                }

                nv._p_.customEvent[sName].prototype.fireEvent = function(oCustomEvent){
                    for(var i = 0, l = this.wrap_listener.length; i < l; i ++){
                        this.wrap_listener[i](oCustomEvent);
                    }
                };
            }
            return this;
    }
};
//-!nv.$Event.customEvent end!-//


//-!nv.$Event.prototype.mouse start!-//
/**
 	mouse() �޼���� ���콺 �̺�Ʈ ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method mouse
	@param {Boolean} [bIsScrollbar=false] true�̸� scroll�Ӽ��� �� �� �ִ�. (2.0.0 �������� ����).
	@return {Object} ���콺 �̺�Ʈ ������ ���� ��ü.
		@return {Number} .delta ���콺 ���� ���� ������ ������ �����Ѵ�. ���콺 ���� ���� ���� ������ ��� ������, �Ʒ��� ���� ������ ���� ������ �����Ѵ�.
		@return {Boolean} .left ���콺 ���� ��ư Ŭ�� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .middle ���콺 ��� ��ư Ŭ�� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .right ���콺 ������ ��ư Ŭ�� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .scroll �̺�Ʈ�� ��ũ�ѿ��� �߻��ߴ����� �� �� �ִ�.
	@filter desktop
	@example
		function eventHandler(evt) {
		   var mouse = evt.mouse();
		
		   mouse.delta;   // Number. ���� ������ ����. ���� ���� ������ ���, �Ʒ��� ������ ����.
		   mouse.left;    // ���콺 ���� ��ư�� �Էµ� ��� true, �ƴϸ� false
		   mouse.middle;  // ���콺 �߰� ��ư�� �Էµ� ��� true, �ƴϸ� false
		   mouse.right;   // ���콺 ������ ��ư�� �Էµ� ��� true, �ƴϸ� false
		}
 */
nv.$Event.prototype.mouse = function(bIsScrollbar) {
	//-@@$Event.mouse-@@//
	g_checkVarType(arguments,{
		"voi" : [],
		"bol" : ["bIsScrollbar:Boolean"]
	});
	var e    = this._event;
	var ele  = this.srcElement;
	var delta = 0;
	var left = false,mid = false,right = false;

	var left  = e.which ? e.button==0 : !!(e.button&1);
	var mid   = e.which ? e.button==1 : !!(e.button&4);
	var right = e.which ? e.button==2 : !!(e.button&2);
	var ret   = {};

	if (e.wheelDelta) {
		delta = e.wheelDelta / 120;
	} else if (e.detail) {
		delta = -e.detail / 3;
	}
	var scrollbar;
	if(bIsScrollbar){
		scrollbar = _event_isScroll(ele,e);
	}
	
				
	ret = {
		delta  : delta,
		left   : left,
		middle : mid,
		right  : right,
		scrollbar : scrollbar
	};
	// replace method
	this.mouse = function(bIsScrollbar){
		if(bIsScrollbar){
			ret.scrollbar = _event_isScroll(this.srcElement,this._event);
			this.mouse = function(){return ret;};
		} 
		return ret;
	};

	return ret;
};
/**
 * @ignore
 */
function _event_getScrollbarSize() {
	
	var oScrollbarSize = { x : 0, y : 0 };
		
	var elDummy = nv.$([
		'<div style="',
		[
			'overflow:scroll',
			'width:100px',
			'height:100px',
			'position:absolute',
			'left:-1000px',
			'border:0',
			'margin:0',
			'padding:0'
		].join(' !important;'),
		' !important;">'
	].join(''));
	
	document.body.insertBefore(elDummy, document.body.firstChild);
	
	oScrollbarSize = {
		x : elDummy.offsetWidth - elDummy.scrollWidth,
		y : elDummy.offsetHeight - elDummy.scrollHeight
	};
	
	document.body.removeChild(elDummy);
	elDummy = null;
	
	_event_getScrollbarSize = function() {
		return oScrollbarSize;
	};
	
	return oScrollbarSize;
	
}
/**
 * @ignore
 */
function _ie_check_scroll(ele,e) {
    var iePattern = nv._p_._j_ag.match(/(?:MSIE) ([0-9.]+)/);
    if(document.body.componentFromPoint&&iePattern&& parseInt(iePattern[1],10) == 8){
        _ie_check_scroll = function(ele,e) {
            return !/HTMLGenericElement/.test(ele+"") && 
                    /(scrollbar|outside)/.test(ele.componentFromPoint(e.clientX, e.clientY)) &&
                    ele.clientHeight !== ele.scrollHeight;
        };
    }else{
        _ie_check_scroll = function(ele,e){
            return /(scrollbar|outside)/.test(ele.componentFromPoint(e.clientX, e.clientY));
        };
    }
    return _ie_check_scroll(ele,e);
}


function _event_isScroll(ele,e){
	/**
	 	// IE �� ��� componentFromPoint �޼��带 �����ϹǷ� �̰� Ȱ��
	 */
	if (ele.componentFromPoint) {
		return _ie_check_scroll(ele,e);
	}
	
	/**
	 	// ���̾������� ��ũ�ѹ� Ŭ���� XUL ��ü�� ����
	 */
	if (nv._p_._JINDO_IS_FF) {
		
		try {
			var name = e.originalTarget.localName;
			return (
				name === 'thumb' ||
				name === 'slider' ||
				name === 'scrollcorner' ||
				name === 'scrollbarbutton'
			);
		} catch(ex) {
			return true;
		}
		
	}
	
	var sDisplay = nv.$Element(ele).css('display');
	if (sDisplay === 'inline') { return false; }
	
	/**
	 	// ������Ʈ ������ Ŭ���� ��ġ ���
	 */
	var oPos = {
		x : e.offsetX || 0,
		y : e.offsetY || 0
	};
	
	/**
	 	// Webkit �� ��� border �� ����� �������� ����
	 */
	if (nv._p_._JINDO_IS_WK) {
		oPos.x -= ele.clientLeft;
		oPos.y -= ele.clientTop;
	}
	
	var oScrollbarSize = _event_getScrollbarSize();
	
	/**
	 	// ��ũ�ѹٰ� �ִ� ����
	 */
	var oScrollPos = {
		x : [ ele.clientWidth, ele.clientWidth + oScrollbarSize.x ],
		y : [ ele.clientHeight, ele.clientHeight + oScrollbarSize.y ]
	};
	
	return (
		(oScrollPos.x[0] <= oPos.x && oPos.x <= oScrollPos.x[1]) ||
		(oScrollPos.y[0] <= oPos.y && oPos.y <= oScrollPos.y[1])
	);
}
//-!nv.$Event.prototype.mouse end!-//

//-!nv.$Event.prototype.key start!-//
/**
 	key() �޼���� Ű���� �̺�Ʈ ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method key
	@return {Object} Ű���� �̺�Ʈ ������ ���� ��ü.
		@return {Boolean} .alt ALT Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .ctrl CTRL Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .down �Ʒ��� ����Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .enter ����(enter)Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .esc ESC Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .keyCode �Է��� Ű�� �ڵ� ���� ���� ���·� �����Ѵ�.
		@return {Boolean} .left ���� ����Ű �Է� ���θ� �Ҹ��� ���� �����Ѵ�.
		@return {Boolean} .meta METAŰ(Mac �� Ű������ Command Ű) �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .right ������ ����Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .shift ShiftŰ �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
		@return {Boolean} .up ���� ����Ű �Է� ���θ� �Ҹ��� ���·� �����Ѵ�.
	@example
		function eventHandler(evt) {
		   var key = evt.key();
		
		   key.keyCode; // Number. Ű������ Ű�ڵ�
		   key.alt;     // Alt Ű�� �Էµ� ��� true.
		   key.ctrl;    // Ctrl Ű�� �Էµ� ��� true.
		   key.meta;    // Meta Ű�� �Էµ� ��� true.
		   key.shift;   // Shift Ű�� �Էµ� ��� true.
		   key.up;      // ���� ȭ��ǥ Ű�� �Էµ� ��� true.
		   key.down;    // �Ʒ��� ȭ��ǥ Ű�� �Էµ� ��� true.
		   key.left;    // ���� ȭ��ǥ Ű�� �Էµ� ��� true.
		   key.right;   // ������ ȭ��ǥ Ű�� �Էµ� ��� true.
		   key.enter;   // ����Ű�� �������� true
		   key.esc;   // ESCŰ�� �������� true
		}
 */
nv.$Event.prototype.key = function() {
	//-@@$Event.key-@@//
	var e     = this._event;
	var k     = e.keyCode || e.charCode;
	var ret   = {
		keyCode : k,
		alt     : e.altKey,
		ctrl    : e.ctrlKey,
		meta    : e.metaKey,
		shift   : e.shiftKey,
		up      : (k == 38),
		down    : (k == 40),
		left    : (k == 37),
		right   : (k == 39),
		enter   : (k == 13),		
		esc   : (k == 27)
	};

	this.key = function(){ return ret; };

	return ret;
};
//-!nv.$Event.prototype.key end!-//

//-!nv.$Event.prototype.pos start(nv.$Element.prototype.offset)!-//
/**
 	pos() �޼���� ���콺 Ŀ���� ��ġ ������ ��� �ִ� ��ü�� ��ȯ�Ѵ�.
	
	@method pos
	@param {Boolean} [bGetOffset] �̺�Ʈ�� �߻��� ��ҿ��� ���콺 Ŀ���� ��� ��ġ�� offsetX, offsetY ���� ���� �������� ������ �Ķ����. bGetOffset ���� true�� ���� ���Ѵ�.
	@return {Object} ���콺 Ŀ���� ��ġ ����.
		@return {Number} .clientX ȭ���� �������� ���콺 Ŀ���� X��ǥ�� �����Ѵ�.
		@return {Number} .clientY ȭ���� �������� ���콺 Ŀ���� Y��ǥ�� �����Ѵ�.
		@return {Number} .offsetX DOM ��Ҹ� �������� ���콺 Ŀ���� ������� X��ǥ�� �����Ѵ�.
		@return {Number} .offsetY DOM ��Ҹ� �������� ���콺 Ŀ���� ������� Y��ǥ�� �����Ѵ�.
		@return {Number} .pageX ������ �������� ���콺 Ŀ���� X ��ǥ�� �����Ѵ�.
		@return {Number} .pageY ������ �������� ���콺 Ŀ���� Y��ǥ�� �����Ѵ�.
	@remark 
		<ul class="disc">
			<li>pos() �޼��带 ����Ϸ��� Jindo �����ӿ�ũ�� $Element() ��ü�� ���ԵǾ� �־�� �Ѵ�.</li>
		</ul>
	@example
		function eventHandler(evt) {
		   var pos = evt.pos();
		
		   pos.clientX;  // ���� ȭ�鿡 ���� X ��ǥ
		   pos.clientY;  // ���� ȭ�鿡 ���� Y ��ǥ
		   pos.offsetX; // �̺�Ʈ�� �߻��� ������Ʈ�� ���� ���콺 Ŀ���� ������� X��ǥ (1.2.0 �̻�)
		   pos.offsetY; // �̺�Ʈ�� �߻��� ������Ʈ�� ���� ���콺 Ŀ���� ������� Y��ǥ (1.2.0 �̻�)
		   pos.pageX;  // ���� ��ü�� ���� X ��ǥ
		   pos.pageY;  // ���� ��ü�� ���� Y ��ǥ
		}
 */
nv.$Event.prototype.pos = function(bGetOffset) {
	//-@@$Event.pos-@@//
	g_checkVarType(arguments,{
		"voi" : [],
		"bol" : ["bGetOffset:Boolean"]
	});

	var e = this._posEvent;
	var doc = (this.srcElement.ownerDocument||document);
	var b = doc.body;
	var de = doc.documentElement;
	var pos = [b.scrollLeft || de.scrollLeft, b.scrollTop || de.scrollTop];
	var ret = {
		clientX: e.clientX,
		clientY: e.clientY,
		pageX: 'pageX' in e ? e.pageX : e.clientX+pos[0]-b.clientLeft,
		pageY: 'pageY' in e ? e.pageY : e.clientY+pos[1]-b.clientTop
	};

    /*
     �������� ���ϴ� �޼����� ����� ũ�Ƿ�, ��û�ÿ��� ���ϵ��� �Ѵ�.
     */
	if (bGetOffset && nv.$Element) {
		var offset = nv.$Element(this.srcElement).offset();
		ret.offsetX = ret.pageX - offset.left;
		ret.offsetY = ret.pageY - offset.top;
	}

	return ret;
};
//-!nv.$Event.prototype.pos end!-//

//-!nv.$Event.prototype.stop start!-//
/**
 	stop() �޼���� �̺�Ʈ�� ������ �⺻ ������ ������Ų��. ������ Ư�� HTML ������Ʈ���� �̺�Ʈ�� �߻����� �� �̺�Ʈ�� ���� ���� ���ĵǴ� �����̴�. ���� ���, &lt;div&gt; ��Ҹ� Ŭ���� �� &lt;div&gt; ��ҿ� �Բ� ���� ����� document ��ҿ��� onclick �̺�Ʈ�� �߻��Ѵ�. stop() �޼���� ������ ��ü������ �̺�Ʈ�� �߻��ϵ��� ������ �����Ѵ�.
	
	@method stop
	@param {Numeric} [nCancelConstant=$Event.CANCEL_ALL] $Event() ��ü�� ���. ������ ����� ���� �̺�Ʈ�� ������ �⺻ ������ �����Ͽ� ������Ų��. (1.1.3 �������� ����).
		@param {Numeric} [nCancelConstant.$Event.CANCEL_ALL] ������ �⺻ ������ ��� ����
		@param {Numeric} nCancelConstant.$Event.CANCEL_BUBBLE ������ ����
		@param {Numeric} nCancelConstant.$Event.CANCEL_DEFAULT �⺻ ������ ����
	@return {this} â�� ������ �⺻ ������ ������ �ν��Ͻ� �ڽ�
	@see nv.$Event.CANCEL_ALL
	@see nv.$Event.CANCEL_BUBBLE
	@see nv.$Event.CANCEL_DEFAULT
	@example
		// �⺻ ���۸� ������Ű�� ���� �� (1.1.3���� �̻�)
		function stopDefaultOnly(evt) {
			// Here is some code to execute
		
			// Stop default event only
			evt.stop($Event.CANCEL_DEFAULT);
		}
 */
nv.$Event.prototype.stop = function(nCancel) {
	//-@@$Event.stop-@@//
	g_checkVarType(arguments,{
		"voi" : [],
		"num" : ["nCancel:Numeric"]
	});
	nCancel = nCancel || nv.$Event.CANCEL_ALL;

	var e = (window.event && window.event == this._globalEvent)?this._globalEvent:this._event;
	var b = !!(nCancel & nv.$Event.CANCEL_BUBBLE); // stop bubbling
	var d = !!(nCancel & nv.$Event.CANCEL_DEFAULT); // stop default event
	var type = this.realType;
	if(b&&(type==="focusin"||type==="focusout")){
	    nv.$Jindo._warn("The "+type +" event can't stop bubble.");
	}

	this.canceled = true;
	
	if(d){
	    if(e.preventDefault !== undefined){
	        e.preventDefault();
	    }else{
	        e.returnValue = false;
	    }
	}
	
	if(b){
	    if(e.stopPropagation !== undefined){
	        e.stopPropagation();
	    }else{
	        e.cancelBubble = true;
	    }
	}

	return this;
};

/**
 	stopDefault() �޼���� �̺�Ʈ�� �⺻ ������ ������Ų��. stop() �޼����� �Ķ���ͷ� CANCEL_DEFAULT ���� �Է��� �Ͱ� ����.
	
	@method stopDefault
	@return {this} �̺�Ʈ�� �⺻ ������ ������ �ν��Ͻ� �ڽ�
	@see nv.$Event#stop
	@see nv.$Event.CANCEL_DEFAULT
 */
nv.$Event.prototype.stopDefault = function(){
	return this.stop(nv.$Event.CANCEL_DEFAULT);
};

/**
 	stopBubble() �޼���� �̺�Ʈ�� ������ ������Ų��. stop() �޼����� �Ķ���ͷ� CANCEL_BUBBLE ���� �Է��� �Ͱ� ����.
	
	@method stopBubble
	@return {this} �̺�Ʈ�� ������ ������ �ν��Ͻ� �ڽ�
	@see nv.$Event#stop
	@see nv.$Event.CANCEL_BUBBLE
 */
nv.$Event.prototype.stopBubble = function(){
	return this.stop(nv.$Event.CANCEL_BUBBLE);
};

/**
 	CANCEL_BUBBLE�� stop() �޼��忡�� ������ ������ų �� ���Ǵ� ����̴�.
	
	@property CANCEL_BUBBLE
	@static
	@constant
	@type Number
	@default 1
	@see nv.$Event#stop
	@final
 */
nv.$Event.CANCEL_BUBBLE = 1;

/**
 	CANCEL_DEFAULT�� stop() �޼��忡�� �⺻ ������ ������ų �� ���Ǵ� ����̴�.
	
	@property CANCEL_DEFAULT
	@static
	@constant
	@type Number
	@default 2
	@see nv.$Event#stop
	@final
 */
nv.$Event.CANCEL_DEFAULT = 2;

/**
 	CANCEL_ALL�� stop() �޼��忡�� ������ �⺻ ������ ��� ������ų �� ���Ǵ� ����̴�.
	
	@property CANCEL_ALL
	@static
	@constant
	@type Number
	@default 3
	@see nv.$Event#stop
	@final
 */
nv.$Event.CANCEL_ALL = 3;
//-!nv.$Event.prototype.stop end!-//

//-!nv.$Event.prototype.$value start!-//
/**
 	$value �޼���� ���� Event ��ü�� �����Ѵ�
	
	@method $value
	@return {Event} ���� Event ��ü
	@example
		function eventHandler(evt){
			evt.$value();
		}
 */
nv.$Event.prototype.$value = function() {
	//-@@$Event.$value-@@//
	return this._event;
};
//-!nv.$Event.prototype.$value end!-//

//-!nv.$Event.prototype.changedTouch start(nv.$Event.prototype.targetTouch,nv.$Event.prototype.touch)!-//
/**
 	����Ͽ��� touch���� �̺�Ʈ�� ���� changeTouches��ü�� �� �� ���� ����ϵ��� �Ѵ�.
	
	@method changedTouch
	@param {Numeric} [nIndex] �ε��� ��ȣ, �� �ɼ��� �������� ������ ���� ���� �����Ͱ� ����ִ� �迭�� �����Ѵ�.
	@return {Array | Hash} ���� ���� �����Ͱ� ����ִ� �迭 �Ǵ� ���� ���� ������
	@throws {$Except.NOT_SUPPORT_METHOD} ����ũž���� ����� �� ���ܻ�Ȳ �߻�.
	@filter mobile
	@since 2.0.0 
	@see nv.$Event#targetTouch
	@see nv.$Event#pos
	@example
		$Element("only_mobile").attach("touchstart",function(e){
			e.changedTouch(0);
			{
			   "id" : "123123",// identifier
			   "event" : $Event,// $Event
			   "element" : element, // �ش� ������Ʈ
			   "pos" : function(){}//  �޼��� (Pos�޼���� ����)
			}
			
		 	e.changedTouch();
			[
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				},
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				}
			]
		 });
 */
(function(aType){
	var sTouches = "Touch", sMethod = "";

	for(var i=0, l=aType.length; i < l; i++) {
        sMethod = aType[i]+sTouches;
        if(!aType[i]) { sMethod = sMethod.toLowerCase(); }

		nv.$Event.prototype[sMethod] = (function(sType) {
			return function(nIndex) {
				if(this.isTouch) {
					var oRet = [];
					var ev = this._event[sType+"es"];
					var l = ev.length;
					var e;
					for(var i = 0; i < l; i++){
						e = ev[i];
						oRet.push({
							"id" : e.identifier,
							"event" : this,
							"element" : e.target,
							"_posEvent" : e,
							"pos" : nv.$Event.prototype.pos
						});
					}
					this[sType] = function(nIndex) {
						var oArgs = g_checkVarType(arguments, {
							'void' : [  ],
							'4num' : [ 'nIndex:Numeric' ]
						},"$Event#"+sType);
						if(oArgs+"" == 'void') return oRet;
						
						return oRet[nIndex];
					};
				} else {
					this[sType] = function(nIndex) {
						throw new nv.$Error(nv.$Except.NOT_SUPPORT_METHOD,"$Event#"+sType);
					};
				}
				
				return this[sType].apply(this,nv._p_._toArray(arguments));
			};
		})(sMethod);
	}
})(["changed","target",""]);
//-!nv.$Event.prototype.changedTouch end!-//

//-!nv.$Event.prototype.targetTouch start(nv.$Event.prototype.changedTouch)!-//
/**
 	����Ͽ��� touch���� �̺�Ʈ�� ���� targetTouches��ü�� �� �� ���� ����ϵ��� �Ѵ�.
	
	@method targetTouch
	@param {Numeric} [nIndex] �ε��� ��ȣ, �� �ɼ��� �������� ������ ���� ���� �����Ͱ� ����ִ� �迭�� �����Ѵ�.
	@return {Array | Hash} ���� ���� �����Ͱ� ����ִ� �迭 �Ǵ� ���� ���� ������
	@throws {$Except.NOT_SUPPORT_METHOD} ����ũž���� ����� �� ���ܻ�Ȳ �߻�.
	@filter mobile
	@since 2.0.0
	@see nv.$Event#changedTouch
	@see nv.$Event#pos
	@example
		$Element("only_mobile").attach("touchstart",function(e){
			e.targetTouch(0);
			{
			   "id" : "123123",// identifier
			   "event" : $Event,// $Event
			   "element" : element, // �ش� ������Ʈ
			   "pos" : function(){}//  �޼��� (Pos�޼���� ����)
			}
			
			e.targetTouch();
			[
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				},
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				}
			]
		 });
 */
//-!nv.$Event.prototype.targetTouch end!-//

//-!nv.$Event.prototype.touch start(nv.$Event.prototype.changedTouch)!-//
/**
 	����Ͽ��� touch���� �̺�Ʈ�� ���� touches��ü�� �� �� ���� ����ϵ��� �Ѵ�.

	@method touch
	@param {Numeric} [nIndex] �ε��� ��ȣ, �� �ɼ��� �������� ������ ���� ���� �����Ͱ� ����ִ� �迭�� �����Ѵ�.
	@return {Array | Hash} ���� ���� �����Ͱ� ����ִ� �迭 �Ǵ� ���� ���� ������
	@throws {$Except.NOT_SUPPORT_METHOD} ����ũž���� ����� �� ���ܻ�Ȳ �߻�.
	@filter mobile
	@since 2.0.0
	@see nv.$Event#changedTouch
	@see nv.$Event#pos
	@example
		$Element("only_mobile").attach("touchstart",function(e){
			e.touch(0);
			{
			   "id" : "123123",// identifier
			   "event" : $Event,// $Event
			   "element" : element, // �ش� ������Ʈ
			   "pos" : function(){}//  �޼��� (Pos�޼���� ����)
			}

			e.touch();
			[
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				},
				{
				   "id" : "123123",
				   "event" : $Event,
				   "element" : element,
				   "pos" : function(){}
				}
			]
		 });
 */
//-!nv.$Event.prototype.touch end!-//

/**
 	@fileOverview $Element�� ������ �� �޼��带 ������ ����
	@name element.js
	@author NAVER Ajax Platform
 */
//-!nv.$Element start(nv.$)!-//
/**
 	nv.$Element() ��ü�� HTML ��Ҹ� ����(wrapping)�ϸ�, �ش� ��Ҹ� �� �� ���� �ٷ� �� �ִ� ����� �����Ѵ�.
	
	@class nv.$Element
	@keyword element, ������Ʈ
 */
/**
 	nv.$Element() ��ü�� �����Ѵ�.
	 
	@constructor
	@param {Variant} vElement nv.$Element() ��ü �����ڴ� ���ڿ�(String), HTML ���(Element+|Node|Document+|Window+), �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.<br>
		<ul class="disc">
			<li>�Ķ���Ͱ� ���ڿ��̸� �� ���� ������� �����Ѵ�.
				<ul class="disc">
					<li>���� "&lt;tagName&gt;"�� ���� ������ ���ڿ��̸� tagName�� ������ ��ü�� �����Ѵ�.</li>
					<li>�� �̿��� ��� ������ ���ڿ��� ID�� ���� HTML ��Ҹ� ����Ͽ� nv.$Element() ��ü�� �����Ѵ�.</li>
				</ul>
			</li>
			<li>�Ķ���Ͱ� HTML ����̸� �ش� ��Ҹ� �����Ͽ� $Element() �� �����Ѵ�.</li>
			<li>�Ķ���Ͱ� $Element()�̸� ���޵� �Ķ���͸� �״�� ��ȯ�Ѵ�.</li>
			<li>�Ķ���Ͱ� undefined Ȥ�� null�� ��� null�� ��ȯ�Ѵ�.</li>
		</ul>
	@return {nv.$Element} ������ nv.$Element() ��ü.
	@example
		var element = $Element($("box")); // HTML ��Ҹ� �Ķ���ͷ� ����
		var element = $Element("box"); // HTML ����� id�� �Ķ���ͷ� ����
		var element = $Element("<div>"); // �±׸� �Ķ���ͷ� ����, DIV ������Ʈ�� �����Ͽ� ������
 */
nv.$Element = function(el) {
    //-@@$Element-@@//
    var cl = arguments.callee;
    if (el && el instanceof cl) return el;  
    
    if (!(this instanceof cl)){
        try {
            nv.$Jindo._maxWarn(arguments.length, 1,"$Element");
            return new cl(el);
        } catch(e) {
            if (e instanceof TypeError) { return null; }
            throw e;
        }
    }   
    var cache = nv.$Jindo;
    var oArgs = cache.checkVarType(arguments, {
        '4str' : [ 'sID:String+' ],
        '4nod' : [ 'oEle:Node' ],
        '4doc' : [ 'oEle:Document+' ],
        '4win' : [ 'oEle:Window+' ]
    },"$Element");
    switch(oArgs + ""){
        case "4str":
            el = nv.$(el);
            break;
        default:
            el = oArgs.oEle;
    }
    
    this._element = el;
    if(this._element != null){
        if(this._element.__nv__id){
            this._key = this._element.__nv__id; 
        }else{
            try{
                this._element.__nv__id = this._key = nv._p_._makeRandom();
            }catch(e){}
        }
        // tagname
        this.tag = (this._element.tagName||'').toLowerCase();
    }else{
        throw new TypeError("{not_found_element}");
    }

};
nv._p_.NONE_GROUP = "_nv_event_none";
nv._p_.splitEventSelector = function(sEvent){
    var matches = sEvent.match(/^([a-z_]*)(.*)/i);
    var eventName = nv._p_.trim(matches[1]);
    var selector = nv._p_.trim(matches[2].replace("@",""));
    return {
        "type"      : selector?"delegate":"normal",
        "event"     : eventName,
        "selector"  : selector
    };
};
nv._p_._makeRandom = function(){
    return "e"+ new Date().getTime() + parseInt(Math.random() * 100000000,10);
};

nv._p_.releaseEventHandlerForAllChildren = function(wel){
	var children = wel._element.all || wel._element.getElementsByTagName("*"),
		nChildLength = children.length,
		elChild = null,
		i;
	
	for(i = 0; i < nChildLength; i++){
		elChild = children[i];
		
		if(elChild.nodeType == 1 && elChild.__nv__id){
			nv.$Element.eventManager.cleanUpUsingKey(elChild.__nv__id, true);
		}
	}
	
	children = elChild = null;
};

nv._p_.canUseClassList = function(){
    var result = "classList" in document.body&&"classList" in document.createElementNS("http://www.w3.org/2000/svg", "g");
    nv._p_.canUseClassList = function(){
        return result;
    };
    return nv._p_.canUseClassList();
};

nv._p_.vendorPrefixObj = {
    "-moz" : "Moz",
    "-ms" : "ms",
    "-o" : "O",
    "-webkit" : "webkit"
};

nv._p_.cssNameToJavaScriptName = function(sName){
    if(/^(\-(?:moz|ms|o|webkit))/.test(sName)){
        var vandorPerfix = RegExp.$1;
        sName = sName.replace(vandorPerfix,nv._p_.vendorPrefixObj[vandorPerfix]);
    }
    
    return sName.replace(/(:?-(\w))/g,function(_,_,m){
       return m.toUpperCase();
    });
};

//-!nv.$Element._getTransition.hidden start!-//
/**
 {{sign_getTransition}}
 */

nv._p_.getStyleIncludeVendorPrefix = function(_test){
    var styles = ["Transition","Transform","Animation","Perspective"];
    var vendors = ["webkit","-","Moz","O","ms"];

    // when vender prefix is not present,  the value will be taken from  prefix
    var style  = "";
    var vendor = "";
    var vendorStyle = "";
    var result = {};
    
    var styleObj = _test||document.body.style;
    for(var i = 0, l = styles.length; i < l; i++){
        style = styles[i];
        
        for(var j = 0, m = vendors.length; j < m; j++ ){
            vendor = vendors[j];
            vendorStyle = vendor!="-"?(vendor+style):style.toLowerCase(); 
            if(typeof styleObj[vendorStyle] !== "undefined"){
                result[style.toLowerCase()] = vendorStyle;
                break;
            }
            result[style.toLowerCase()] = false;
        }    
    }
    
    if(_test){
        return result;
    }
    
    nv._p_.getStyleIncludeVendorPrefix = function(){
        return result;
    };
    
    return nv._p_.getStyleIncludeVendorPrefix();
};

nv._p_.getTransformStringForValue = function(_test){
    var info = nv._p_.getStyleIncludeVendorPrefix(_test);
    var transform = info.transform ;
    if(info.transform === "MozTransform"){
        transform = "-moz-transform";
    }else if(info.transform === "webkitTransform"){
        transform = "-webkit-transform";
    }else if(info.transform === "OTransform"){
        transform = "-o-transform";
    }else if(info.transform === "msTransform"){
        transform = "-ms-transform";
    }
    
    if(_test){
        return transform;
    }
    
    nv._p_.getTransformStringForValue = function(){
        return transform;
    };
    
    return nv._p_.getTransformStringForValue();
};
/*
 {{disappear_1}}
 */
// To prevent blink issue on Android 4.0.4 Samsung Galaxy 2 LTE model, calculate offsetHeight first
nv._p_.setOpacity = function(ele,val){
    ele.offsetHeight;
    ele.style.opacity = val;
};
//-!nv.$Element._getTransition.hidden end!-//

/**
 	@method _eventBind
	@ignore
 */
nv.$Element._eventBind = function(oEle,sEvent,fAroundFunc,bUseCapture){
    if(oEle.addEventListener){
        if(document.documentMode == 9){
            nv.$Element._eventBind = function(oEle,sEvent,fAroundFunc,bUseCapture){
                if(/resize/.test(sEvent) ){
                    oEle.attachEvent("on"+sEvent,fAroundFunc);
                }else{
                    oEle.addEventListener(sEvent, fAroundFunc, !!bUseCapture);
                }
            };
        }else{
            nv.$Element._eventBind = function(oEle,sEvent,fAroundFunc,bUseCapture){
                oEle.addEventListener(sEvent, fAroundFunc, !!bUseCapture);
            };
        }
    }else{
        nv.$Element._eventBind = function(oEle,sEvent,fAroundFunc){
            oEle.attachEvent("on"+sEvent,fAroundFunc);
        };
    }
    nv.$Element._eventBind(oEle,sEvent,fAroundFunc,bUseCapture);
};

/**
 	@method _unEventBind
	@ignore
 */
nv.$Element._unEventBind = function(oEle,sEvent,fAroundFunc){
    if(oEle.removeEventListener){
        if(document.documentMode == 9){
            nv.$Element._unEventBind = function(oEle,sEvent,fAroundFunc){
                if(/resize/.test(sEvent) ){
                    oEle.detachEvent("on"+sEvent,fAroundFunc);
                }else{
                    oEle.removeEventListener(sEvent,fAroundFunc,false);
                }
            };
        }else{
            nv.$Element._unEventBind = function(oEle,sEvent,fAroundFunc){
                oEle.removeEventListener(sEvent,fAroundFunc,false);
            };
        }
    }else{
        nv.$Element._unEventBind = function(oEle,sEvent,fAroundFunc){
            oEle.detachEvent("on"+sEvent,fAroundFunc);
        };
    }
    nv.$Element._unEventBind(oEle,sEvent,fAroundFunc);
};
//-!nv.$Element end!-//


//-!nv.$Element.prototype.$value start!-//
/**
 	$value() �޼���� ������ HTML ��Ҹ� ��ȯ�Ѵ�.
	
	@method $value
	@return {Element} nv.$Element() ��ü�� ���ΰ� �ִ� ���� ���.
	@see nv.$Element
	@example
		var element = $Element("sample_div");
		element.$value(); // ������ ������Ʈ�� ��ȯ�ȴ�.
 */
nv.$Element.prototype.$value = function() {
    //-@@$Element.$value-@@//
    return this._element;
};
//-!nv.$Element.prototype.$value end!-//

//-!nv.$Element.prototype.visible start(nv.$Element.prototype._getCss,nv.$Element.prototype.show,nv.$Element.prototype.hide)!-//
/**
 	visible() �޼���� HTML ����� display �Ӽ��� ��ȸ�Ѵ�.
	
	@method visible
	@return {Boolean} display ����. display �Ӽ��� none�̸� false ���� ��ȯ�Ѵ�.
	@example
		<div id="sample_div" style="display:none">Hello world</div>
		
		// ��ȸ
		$Element("sample_div").visible(); // false 
 */
/**
 	visible() �޼���� HTML ����� display �Ӽ��� �����Ѵ�.
	
	@method visible
	@param {Boolean} bVisible �ش� ����� ǥ�� ����.<br>�Է��� �Ķ���Ͱ� true�� ��� display �Ӽ��� �����ϰ�, false�� ��쿡�� display �Ӽ��� none���� �����Ѵ�. Boolean�� �ƴ� ���� ���� ���� ToBoolean�� ����� �������� �����Ѵ�.
	@param {String+} sDisplay �ش� ����� display �Ӽ� ��.<br>bVisible �Ķ���Ͱ� true �̸� sDisplay ���� display �Ӽ����� �����Ѵ�.
	@return {this} display �Ӽ��� ������ �ν��Ͻ� �ڽ�
	@remark 
		<ul class="disc">
			<li>1.1.2 �������� bVisible �Ķ���͸� ����� �� �ִ�.</li>
			<li>1.4.5 �������� sDisplay �Ķ���͸� ����� �� �ִ�.</li>
		</ul>
	@see http://www.w3.org/TR/2008/REC-CSS2-20080411/visuren.html#display-prop display �Ӽ� - W3C CSS2 Specification
	@see nv.$Element#show
	@see nv.$Element#hide
	@see nv.$Element#toggle
	@example
		// ȭ�鿡 ���̵��� ����
		$Element("sample_div").visible(true, 'block');
		
		//Before
		<div id="sample_div" style="display:none">Hello world</div>
		
		//After
		<div id="sample_div" style="display:block">Hello world</div>
 */
nv.$Element.prototype.visible = function(bVisible, sDisplay) {
    //-@@$Element.visible-@@//
    var oArgs = g_checkVarType(arguments, {
        'g' : [  ],
        's4bln' : [ nv.$Jindo._F('bVisible:Boolean') ],
        's4str' : [ 'bVisible:Boolean', "sDisplay:String+"]
    },"$Element#visible");
    switch(oArgs+""){
        case "g":
            return (this._getCss(this._element,"display") != "none");
            
        case "s4bln":
            this[bVisible?"show":"hide"]();
            return this;
            
        case "s4str":
            this[bVisible?"show":"hide"](sDisplay);
            return this;
                    
    }
};
//-!nv.$Element.prototype.visible end!-//

//-!nv.$Element.prototype.show start!-//
/**
 	show() �޼���� HTML ��Ұ� ȭ�鿡 ���̵��� display �Ӽ��� �����Ѵ�.
	
	@method show
	@param {String+} [sDisplay] display �Ӽ��� ������ ��.<br>�Ķ���͸� �����ϸ� �±׺��� �̸� ������ �⺻���� �Ӽ� ������ �����ȴ�. �̸� ������ �⺻���� ������ "inline"���� �����ȴ�. ������ �߻��� ���� "block"���� �����ȴ�.
	@return {this} display �Ӽ��� ������ �ν��Ͻ� �ڽ�
	@remark 1.4.5 �������� sDisplay �Ķ���͸� ����� �� �ִ�.
	@see http://www.w3.org/TR/2008/REC-CSS2-20080411/visuren.html#display-prop display �Ӽ� - W3C CSS2 Specification
	@see nv.$Element#hide
	@see nv.$Element#toggle
	@see nv.$Element#visible
	@example
		// ȭ�鿡 ���̵��� ����
		$Element("sample_div").show();
		
		//Before
		<div id="sample_div" style="display:none">Hello world</div>
		
		//After
		<div id="sample_div" style="display:block">Hello world</div>
 */
nv.$Element.prototype.show = function(sDisplay) {
    //-@@$Element.show-@@//
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [  ],
        '4str' : ["sDisplay:String+"]
    },"$Element#show");
    
    
    var s = this._element.style;
    var b = "block";
    var c = { p:b,div:b,form:b,h1:b,h2:b,h3:b,h4:b,ol:b,ul:b,fieldset:b,td:"table-cell",th:"table-cell",
              li:"list-item",table:"table",thead:"table-header-group",tbody:"table-row-group",tfoot:"table-footer-group",
              tr:"table-row",col:"table-column",colgroup:"table-column-group",caption:"table-caption",dl:b,dt:b,dd:b};
    try {
        switch(oArgs+""){
            case "4voi":
                var type = c[this.tag];
                s.display = type || "inline";
                break;
            case "4str":
                s.display = sDisplay;
                
        }
    } catch(e) {
        /*
         IE���� sDisplay���� ���������϶� block�� �����Ѵ�.
         */
        s.display = "block";
    }

    return this;
};
//-!nv.$Element.prototype.show end!-//

//-!nv.$Element.prototype.hide start!-//
/**
 	hide() �޼���� HTML ��Ұ� ȭ�鿡 ������ �ʵ��� display �Ӽ��� none���� �����Ѵ�.
	
	@method hide
	@return {this} display �Ӽ��� none���� ������ �ν��Ͻ� �ڽ�
	@see http://www.w3.org/TR/2008/REC-CSS2-20080411/visuren.html#display-prop display �Ӽ� - W3C CSS2 Specification
	@see nv.$Element#show
	@see nv.$Element#toggle
	@see nv.$Element#visible
	@example
		// ȭ�鿡 ������ �ʵ��� ����
		$Element("sample_div").hide();
		
		//Before
		<div id="sample_div" style="display:block">Hello world</div>
		
		//After
		<div id="sample_div" style="display:none">Hello world</div>
 */
nv.$Element.prototype.hide = function() {
    //-@@$Element.hide-@@//
    this._element.style.display = "none";

    return this;
};
//-!nv.$Element.prototype.hide end!-//

//-!nv.$Element.prototype.toggle start(nv.$Element.prototype._getCss,nv.$Element.prototype.show,nv.$Element.prototype.hide)!-//
/**
 	toggle() �޼���� HTML ����� display �Ӽ��� �����Ͽ� �ش� ��Ҹ� ȭ�鿡 ���̰ų�, ������ �ʰ� �Ѵ�. �� �޼���� ��ġ ����ġ�� �Ѱ� ���� �Ͱ� ���� ����� ǥ�� ���θ� ������Ų��.
	
	@method toggle
	@param {String+} [sDisplay] �ش� ��Ұ� ���̵��� ������ �� display �Ӽ��� ������ ��. �Ķ���͸� �����ϸ� �±׺��� �̸� ������ �⺻���� �Ӽ� ������ �����ȴ�. �̸� ������ �⺻���� ������ "inline"���� �����ȴ�.
	@return {this} display �Ӽ��� ������ �ν��Ͻ� �ڽ�
	@remark 1.4.5 �������� ���̵��� ������ �� sDisplay ������ display �Ӽ� �� ������ �����ϴ�.
	@see http://www.w3.org/TR/2008/REC-CSS2-20080411/visuren.html#display-prop display �Ӽ� - W3C CSS2 Specification
	@see nv.$Element#show
	@see nv.$Element#hide
	@see nv.$Element#visible
	@example
		// ȭ�鿡 ���̰ų�, ������ �ʵ��� ó��
		$Element("sample_div1").toggle();
		$Element("sample_div2").toggle();
		
		//Before
		<div id="sample_div1" style="display:block">Hello</div>
		<div id="sample_div2" style="display:none">Good Bye</div>
		
		//After
		<div id="sample_div1" style="display:none">Hello</div>
		<div id="sample_div2" style="display:block">Good Bye</div>
 */
nv.$Element.prototype.toggle = function(sDisplay) {
    //-@@$Element.toggle-@@//
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [  ],
        '4str' : ["sDisplay:String+"]
    },"$Element#toggle");
    
    this[this._getCss(this._element,"display")=="none"?"show":"hide"].apply(this,arguments);
    return this;
};
//-!nv.$Element.prototype.toggle end!-//

//-!nv.$Element.prototype.opacity start!-//
/**
 	opacity() �޼���� HTML ����� ����(opacity �Ӽ�) ���� �����´�.
	
	@method opacity
	@return {Numeric} opacity���� ��ȯ�Ѵ�.
	@example
		<div id="sample" style="background-color:#2B81AF; width:20px; height:20px;"></div>
		
		// ��ȸ
		$Element("sample").opacity();	// 1
 */
/**
 	opacity() �޼���� HTML ����� ����(opacity �Ӽ�) ���� �����Ѵ�.
	
	@method opacity
	@param {Variant} vValue ������ ���� ��(String|Numeric). ���� ���� 0���� 1 ������ �Ǽ� ������ �����Ѵ�. ������ �Ķ������ ���� 0���� ������ 0��, 1���� ũ�� 1�� �����Ѵ�. ���ڿ��� ���, ������ opacity �Ӽ��� �����Ѵ�.
	@return {this} opacity �Ӽ��� ������ �ν��Ͻ� �ڽ�
	@example
		// ���� �� ����
		$Element("sample").opacity(0.4);
		
		//Before
		<div style="background-color: rgb(43, 129, 175); width: 20px; height: 20px;" id="sample"></div>
		
		//After
		<div style="background-color: rgb(43, 129, 175); width: 20px; height: 20px; opacity: 0.4;" id="sample"></div>
 */
nv.$Element.prototype.opacity = function(value) {
    //-@@$Element.opacity-@@//
    var oArgs = g_checkVarType(arguments, {
                'g' : [  ],
                's' : ["nOpacity:Numeric"],
                'str' : ['sOpacity:String']
            },"$Element#opacity"),
        e = this._element,
        b = (this._getCss(e,"display") != "none"), v;

    switch(oArgs+""){
        case "g":
            if(typeof e.style.opacity != 'undefined' && (v = e.style.opacity).length || (v = this._getCss(e,"opacity"))) {
                v = parseFloat(v);
                if (isNaN(v)) v = b?1:0;
            } else {
                v = typeof e.filters.alpha == 'undefined'?(b?100:0):e.filters.alpha.opacity;
                v = v / 100;
            }
            return v;   
            
        case "s":
             /*
             IE���� layout�� ������ ���� ������ opacity�� ������� ����.
             */
            value = oArgs.nOpacity;
            e.style.zoom = 1;
            value = Math.max(Math.min(value,1),0);
            
            if (typeof e.style.opacity != 'undefined') {
                e.style.opacity = value;
            } else {
                value = Math.ceil(value*100);
                
                if (typeof e.filters != 'unknown' && typeof e.filters.alpha != 'undefined') {
                    e.filters.alpha.opacity = value;
                } else {
                    e.style.filter = (e.style.filter + " alpha(opacity=" + value + ")");
                }       
            }
            return this;

        case "str":
             /*
             �Ķ���� ���� ����ִ� ������ ���, opacity �Ӽ��� �����Ѵ�.
             */
            if(value === "") {
                e.style.zoom = e.style.opacity = "";
            }
            return this;
    }
    
};
//-!nv.$Element.prototype.opacity end!-//

//-!nv.$Element.prototype.css start(nv.$Element.prototype.opacity,nv.$Element.prototype._getCss,nv.$Element.prototype._setCss)!-//
/**
 	css() �޼���� HTML ����� CSS �Ӽ� ���� ��ȸ�Ѵ�.
	@method css
	@param {String+} vName CSS �Ӽ� �̸�(String)
	@return {String} CSS �Ӽ� ���� ��ȯ�Ѵ�.
	@throws {nv.$Except.NOT_USE_CSS} css�� ����� �� ���� ������Ʈ �� ��.
	@remark 
		<ul class="disc">
			<li>CSS �Ӽ��� ī�� ǥ���(Camel Notation)�� ����Ѵ�. ���� ��� border-width-bottom �Ӽ��� borderWidthBottom���� ������ �� �ִ�.</li>
			<li>2.6.0 �̻󿡼��� �Ϲ����� ��Ÿ�� ������ ī�� ǥ��� ��� ��밡���ϴ�.���� ��� border-width-bottom, borderWidthBottom ��� �����ϴ�.</li>
			<li>float �Ӽ��� JavaScript�� ������ ���ǹǷ� css() �޼��忡���� float ��� cssFloat�� ����Ѵ�(Internet Explorer������ styleFloat, �� ���� ������������ cssFloat�� ����Ѵ�.).</li>
		</ul>
	@see nv.$Element#attr
	@example
		<style type="text/css">
			#btn {
				width: 120px;
				height: 30px;
				background-color: blue;
			}
		</style>
		
		<span id="btn"></span>
		
		// CSS �Ӽ� �� ��ȸ
		$Element('btn').css('backgroundColor');		// rgb (0, 0, 255)
 */
/**
 	css() �޼���� HTML ����� CSS �Ӽ� ���� �����Ѵ�.
	
	@method css
	@syntax vName, vValue
	@syntax oList
	@param {String+} vName CSS �Ӽ� �̸�(String)
	@param {String+ | Numeric} vValue CSS �Ӽ��� ������ ��. ����(Number) Ȥ�� ������ ������ ���ڿ�(String)�� ����Ѵ�.
	@param {Hash+} oList �ϳ� �̻��� CSS �Ӽ��� ���� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} CSS �Ӽ� ���� �ݿ��� �ν��Ͻ� �ڽ�
	@throws {nv.$Except.NOT_USE_CSS} css�� ����� �� ���� ������Ʈ �� ��.
	@remark 
		<ul class="disc">
			<li>CSS �Ӽ��� ī�� ǥ���(Camel Notation)�� ����Ѵ�. ���� ��� border-width-bottom �Ӽ��� borderWidthBottom���� ������ �� �ִ�.</li>
			<li>2.6.0 �̻󿡼��� �Ϲ����� ��Ÿ�� ������ ī�� ǥ��� ��� ��밡���ϴ�.���� ��� border-width-bottom, borderWidthBottom ��� �����ϴ�.</li>
			<li>float �Ӽ��� JavaScript�� ������ ���ǹǷ� css() �޼��忡���� float ��� cssFloat�� ����Ѵ�(Internet Explorer������ styleFloat, �� ���� ������������ cssFloat�� ����Ѵ�.).</li>
		</ul>
	@see nv.$Element#attr
	@example
		// CSS �Ӽ� �� ����
		$Element('btn').css('backgroundColor', 'red');
		
		//Before
		<span id="btn"></span>
		
		//After
		<span id="btn" style="background-color: red;"></span>
	@example
		// �������� CSS �Ӽ� ���� ����
		$Element('btn').css({
			width: "200px",		// 200
			height: "80px"  	// 80 ���� �����Ͽ��� ����� ����
		});
		
		//Before
		<span id="btn" style="background-color: red;"></span>
		
		//After
		<span id="btn" style="background-color: red; width: 200px; height: 80px;"></span>
 */

/**
 	hook() �޼���� CSS���� ��ȸ�Ѵ�.
	@method hook
	@syntax vName
	@static
	@param {String+} vName CSS��(String)
	@remark 2.7.0���� ��밡���ϴ�.
	@return {Variant} CSS�� ��Ÿ���� �� Ȥ�� �Լ�.
	@example
		$Element.hook("textShadow");
		//webkitTextShadow
 */

/**
 	hook() �޼���� �����ڰ� CSS�� ����� �������� �ش� CSS�� ������ �� �����Ͽ� ����Ѵ�.
	@method hook
	@syntax vName, vValue
	@syntax oList
	@static
	@param {String+} vName CSS��(String)
	@param {Variant} vValue ������ CSS��(String|Function)
	@param {Hash+} oList �ϳ� �̻��� CSS ��� ���� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@remark 2.7.0���� ��밡���ϴ�.
	@return {$Element} $Element
	
	
	@example
		$Element.hook("textShadow","webkitTextShadow");
		
		$Element("some").css("textShadow");
		//�̷��� �ϸ� ���������� webkitTextShadow�� ���� ��ȯ.
	@example
		//�Լ��� �Ҵ��� �� �ִ�.
		$Element.hook("textShadow",function(){
			if(isIE&&version>10){
				return "MsTextShadow";
			}else if(isSafari){
				return "webkitTextShadow";
			}else{
				return "textShadow";
			}
		});
		
		$Element("some").css("textShadow");
		///IE�̰� ������ 10�̻��� ���� MsTextShadow���� ������
		//Safari�� ��� webkitTextShadow������ ������
 */

nv._p_._revisionCSSAttr = function(name,vendorPrefix){
    var custumName = nv.$Element.hook(name);
    if(custumName){
        name = custumName;
    }else{
        name = nv._p_.cssNameToJavaScriptName(name).replace(/^(animation|perspective|transform|transition)/i,function(_1){
            return vendorPrefix[_1.toLowerCase()];
        });
    }
    return name;
};

nv._p_.changeTransformValue = function(name,_test){
    return  (name+"").replace(/([\s|-]*)(?:transform)/,function(_,m1){ 
        return nv._p_.trim(m1).length > 0 ? _ : m1+nv._p_.getTransformStringForValue(_test);
    });
};

nv.$Element.prototype.css = function(sName, sValue) {
    //-@@$Element.css-@@//
    var oArgs = g_checkVarType(arguments, {
        'g'     : [ 'sName:String+'],
        's4str' : [ nv.$Jindo._F('sName:String+'), nv.$Jindo._F('vValue:String+') ],
        's4num' : [ 'sName:String+', 'vValue:Numeric' ],
        's4obj' : [ 'oObj:Hash+']
    },"$Element#css");
    
    var e = this._element;

    switch(oArgs+"") {
        case 's4str':
        case 's4num':
            var obj = {};
            sName = nv._p_._revisionCSSAttr(sName,nv._p_.getStyleIncludeVendorPrefix());
            obj[sName] = sValue;
            sName = obj;
            break;
        case 's4obj':
            sName = oArgs.oObj;
            var obj = {};
            var vendorPrefix = nv._p_.getStyleIncludeVendorPrefix();
            for (var i in sName) if (sName.hasOwnProperty(i)){
                obj[nv._p_._revisionCSSAttr(i,vendorPrefix)] = sName[i]; 
            }
            sName = obj;
            break;
        case 'g':
            var vendorPrefix = nv._p_.getStyleIncludeVendorPrefix();
            sName = nv._p_._revisionCSSAttr(sName,vendorPrefix);
            var _getCss = this._getCss;

            if(sName == "opacity"){
                return this.opacity();
            }
            if((nv._p_._JINDO_IS_FF||nv._p_._JINDO_IS_OP)&&(sName=="backgroundPositionX"||sName=="backgroundPositionY")){
                var bp = _getCss(e, "backgroundPosition").split(/\s+/);
                return (sName == "backgroundPositionX") ? bp[0] : bp[1];
            }
            if ((!window.getComputedStyle) && sName == "backgroundPosition") {
                return _getCss(e, "backgroundPositionX") + " " + _getCss(e, "backgroundPositionY");
            }
            if ((!nv._p_._JINDO_IS_OP && window.getComputedStyle) && (sName=="padding"||sName=="margin")) {
                var top     = _getCss(e, sName+"Top");
                var right   = _getCss(e, sName+"Right");
                var bottom  = _getCss(e, sName+"Bottom");
                var left    = _getCss(e, sName+"Left");
                if ((top == right) && (bottom == left)) {
                    return top;
                }else if (top == bottom) {
                    if (right == left) {
                        return top+" "+right;
                    }else{
                        return top+" "+right+" "+bottom+" "+left;
                    }
                }else{
                    return top+" "+right+" "+bottom+" "+left;
                }
            }
            return _getCss(e, sName);
            
    }
    var v, type;

    for(var k in sName) {
        if(sName.hasOwnProperty(k)){
            v    = sName[k];
            if (!(nv.$Jindo.isString(v)||nv.$Jindo.isNumeric(v))) continue;
            if (k == 'opacity') {
                this.opacity(v);
                continue;
            }
            if (k == "cssFloat" && nv._p_._JINDO_IS_IE) k = "styleFloat";
        
            if((nv._p_._JINDO_IS_FF||nv._p_._JINDO_IS_OP)&&( k =="backgroundPositionX" || k == "backgroundPositionY")){
                var bp = this.css("backgroundPosition").split(/\s+/);
                v = k == "backgroundPositionX" ? v+" "+bp[1] : bp[0]+" "+v;
                this._setCss(e, "backgroundPosition", v);
            }else{
                this._setCss(e, k, /transition/i.test(k) ? nv._p_.changeTransformValue(v):v);
            }
        }
    }
    
    return this;
};
//-!nv.$Element.prototype.css end!-//

//-!nv.$Element.prototype._getCss.hidden start!-//
/**
 	css���� ���Ǵ� �Լ�
	
	@method _getCss
	@ignore
	@param {Element} e
	@param {String} sName
 */
nv.$Element.prototype._getCss = function(e, sName){
    var fpGetCss;
    if (window.getComputedStyle) {
        fpGetCss = function(e, sName){
            try{
                if (sName == "cssFloat") sName = "float";
                var d = e.ownerDocument || e.document || document;
                var sVal = e.style[sName];
                if(!e.style[sName]){
                    var computedStyle = d.defaultView.getComputedStyle(e,null);
                    sName = sName.replace(/([A-Z])/g,"-$1").replace(/^(webkit|ms)/g,"-$1").toLowerCase();
                    sVal =  computedStyle.getPropertyValue(sName);
                    sVal =  sVal===undefined?computedStyle[sName]:sVal;
                }
                if (sName == "textDecoration") sVal = sVal.replace(",","");
                return sVal;
            }catch(ex){
                throw new nv.$Error((e.tagName||"document") + nv.$Except.NOT_USE_CSS,"$Element#css");
            }
        };
    
    }else if (e.currentStyle) {
        fpGetCss = function(e, sName){
            try{
                if (sName == "cssFloat") sName = "styleFloat";
                var sStyle = e.style[sName];
                if(sStyle){
                    return sStyle;
                }else{
                    var oCurrentStyle = e.currentStyle;
                    if (oCurrentStyle) {
                        return oCurrentStyle[sName];
                    }
                }
                return sStyle;
            }catch(ex){
                throw new nv.$Error((e.tagName||"document") + nv.$Except.NOT_USE_CSS,"$Element#css");
            }
        };
    } else {
        fpGetCss = function(e, sName){
            try{
                if (sName == "cssFloat" && nv._p_._JINDO_IS_IE) sName = "styleFloat";
                return e.style[sName];
            }catch(ex){
                throw new nv.$Error((e.tagName||"document") + nv.$Except.NOT_USE_CSS,"$Element#css");
            }
        };
    }
    nv.$Element.prototype._getCss = fpGetCss;
    return fpGetCss(e, sName);
    
};
//-!nv.$Element.prototype._getCss.hidden end!-//

//-!nv.$Element.prototype._setCss.hidden start!-//
/**
 	css���� css�� �����ϱ� ���� �Լ�
	
	@method _setCss
	@ignore
	@param {Element} e
	@param {String} k
 */
nv.$Element.prototype._setCss = function(e, k, v){
    if (("#top#left#right#bottom#").indexOf(k+"#") > 0 && (typeof v == "number" ||(/\d$/.test(v)))) {
        e.style[k] = parseInt(v,10)+"px";
    }else{
        e.style[k] = v;
    }
};
//-!nv.$Element.prototype._setCss.hidden end!-//

//-!nv.$Element.prototype.attr start!-//
/**
 	attr() �޼���� HTML ����� �Ӽ��� �����´�. �ϳ��� �Ķ���͸� ����ϸ� ������ �Ӽ��� ���� ��ȯ�ϰ� �ش� �Ӽ��� ���ٸ� null�� ��ȯ�Ѵ�.
	
	@method attr
	@param {String+} sName �Ӽ� �̸�(String)
	@return {String+} �Ӽ� ���� ��ȯ.
	@remark 2.2.0 ���� ���� &lt;select&gt; ������Ʈ�� ����, �ɼǰ��� ������ �� �ִ�.
	@example
		<a href="http://www.naver.com" id="sample_a" target="_blank">Naver</a>
		
		$Element("sample_a").attr("href"); // http://www.naver.com
 */
/**
 	attr() �޼���� HTML ����� �Ӽ��� �����Ѵ�. 
	
	@method attr
	@syntax sName, vValue
	@syntax oList
	@param {String+} sName �Ӽ� �̸�(String).
	@param {Variant} vValue �Ӽ��� ������ ��. ����(Number) Ȥ�� ������ ������ ���ڿ�(String)�� ����Ѵ�. ���� �Ӽ��� ���� null�� �����ϸ� �ش� HTML �Ӽ��� �����Ѵ�.
	@param {Hash+} oList �ϳ� �̻��� �Ӽ��� ���� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} �Ӽ� ���� �ݿ��� �ν��Ͻ� �ڽ�
	@throws {nv.$Except.NOT_USE_CSS} sName�� ����,������Ʈ �� $Hash���� �Ѵ�.
	@remark 2.2.0 ���� ���� &lt;select&gt; ������Ʈ�� ����, �ɼǰ��� ������ �� �ִ�.
	@see nv.$Element#css
	@example
		$Element("sample_a").attr("href", "http://www.hangame.com/");
		
		//Before
		<a href="http://www.naver.com" id="sample_a" target="_blank">Naver</a>
		
		//After
		<a href="http://www.hangame.com" id="sample_a" target="_blank">Naver</a>
	@example
		$Element("sample_a").attr({
		    "href" : "http://www.hangame.com",
		    "target" : "_self"
		})
		
		//Before
		<a href="http://www.naver.com" id="sample_a" target="_blank">Naver</a>
		
		//After
		<a href="http://www.hangame.com" id="sample_a" target="_self">Naver</a>
	@example
		<select id="select">
			<option value="naver">���̹�</option>
			<option value="hangame">�Ѱ���</option>
			<option>��Ϲ�</option>
		</select>
		<script type="text/javascript">
			var wel = $Element("select");
			wel.attr("value"); // "naver"
			wel.attr("value", null).attr("value"); // null
			wel.attr("value", "�Ѱ���").attr("value"); // "hangame"
			wel.attr("value", "��Ϲ�").attr("value"); // "��Ϲ�"
			wel.attr("value", "naver").attr("value"); // "naver"
			wel.attr("value", ["hangame"]).attr("value"); // null
		</script>
	@example
		<select id="select" multiple="true">
			<option value="naver">���̹�</option>
			<option value="hangame">�Ѱ���</option>
			<option>��Ϲ�</option>
		</select>
		<script type="text/javascript">
			var wel = $Element("select");
			wel.attr("value"); // null
			wel.attr("value", "naver").attr("value"); // ["naver"]
			wel.attr("value", null).attr("value"); // null
			wel.attr("value", ["�Ѱ���"]).attr("value"); // ["hangame"]
			wel.attr("value", []).attr("value"); // null
			wel.attr("value", ["���̹�", "hangame"]).attr("value"); // ["naver", "hangame"]
			wel.attr("value", ["��Ϲ�", "me2day"]).attr("value"); // ["��Ϲ�"]
			wel.attr("value", ["naver", "���Ǻ�"]).attr("value"); // ["naver"]
		</script>
 */
nv.$Element.prototype.attr = function(sName, sValue) {
    //-@@$Element.attr-@@//
    var oArgs = g_checkVarType(arguments, {
        'g'     : [ 'sName:String+'],
        's4str' : [ 'sName:String+', 'vValue:String+' ],
        's4num' : [ 'sName:String+', 'vValue:Numeric' ],
        's4nul' : [ 'sName:String+', 'vValue:Null' ],
        's4bln' : [ 'sName:String+', 'vValue:Boolean' ],
        's4arr' : [ 'sName:String+', 'vValue:Array+' ],
        's4obj' : [ nv.$Jindo._F('oObj:Hash+')]
    },"$Element#attr");
    
    var e = this._element,
        aValue = null,
        i,
        length,
        nIndex,
        fGetIndex,
        elOption,
        wa;
    
    switch(oArgs+""){
        case "s4str":
        case "s4nul":
        case "s4num":
        case "s4bln":
        case "s4arr":
            var obj = {};
            obj[sName] = sValue;
            sName = obj;
            break;
        case "s4obj":
            sName = oArgs.oObj;
            break;
        case "g":
            if (sName == "class" || sName == "className"){ 
                return e.className;
            }else if(sName == "style"){
                return e.style.cssText;
            }else if(sName == "checked"||sName == "disabled"){
                return !!e[sName];
            }else if(sName == "value"){
                if(this.tag == "button"){
                    return e.getAttributeNode('value').value;
                }else if(this.tag == "select"){
                    if(e.multiple){
                        for(i = 0, length = e.options.length; i < length; i++){
                            elOption = e.options[i];
                            
                            if(elOption.selected){
                                if(!aValue){
                                    aValue = [];
                                }
                                
                                sValue = elOption.value;
                                
                                if(sValue == ""){
                                    sValue = elOption.text;
                                }
                                
                                aValue.push(sValue);
                            }
                        }
                        return aValue;
                    }else{
                        if(e.selectedIndex < 0){
                            return null;
                        }
                        
                        sValue = e.options[e.selectedIndex].value;
                        return (sValue == "") ? e.options[e.selectedIndex].text : sValue;
                    }
                }else{
                    return e.value;
                }
            }else if(sName == "href"){
                return e.getAttribute(sName,2);
            }
            return e.getAttribute(sName);
    }
    
    fGetIndex = function(oOPtions, vValue){
        var nIndex = -1,
            i,
            length,
            elOption;
        
        for(i = 0, length = oOPtions.length; i < length; i++){
            elOption = oOPtions[i];
            if(elOption.value === vValue || elOption.text === vValue){
                nIndex = i;
                break;
            }
        }
        
        return nIndex;
    };

    for(var k in sName){
        if(sName.hasOwnProperty(k)){
            var v = sName[k];
            // when remove property
            if(nv.$Jindo.isNull(v)){
                if(this.tag == "select"){
                    if(e.multiple){
                        for(i = 0, length = e.options.length; i < length; i++){
                            e.options[i].selected = false;
                        }
                    }else{
                        e.selectedIndex = -1;
                    }
                }else{
                    e.removeAttribute(k);
                }
            }else{
                if(k == "class"|| k == "className"){
                    e.className = v;
                }else if(k == "style"){
                    e.style.cssText = v;
                }else if(k == "checked"||k == "disabled"){
                    e[k] = v;
                }else if(k == "value"){
                    if(this.tag == "select"){
                        if(e.multiple){
                            if(nv.$Jindo.isArray(v)){
                                wa = nv.$A(v);
                                for(i = 0, length = e.options.length; i < length; i++){
                                    elOption = e.options[i];
                                    elOption.selected = wa.has(elOption.value) || wa.has(elOption.text);
                                }
                            }else{
                                e.selectedIndex = fGetIndex(e.options, v);
                            }
                        }else{
                            e.selectedIndex = fGetIndex(e.options, v);
                        }
                    }else{
                        e.value = v;
                    }
                }else{
                    e.setAttribute(k, v);
                }
            } 
        }
    }

    return this;
};
//-!nv.$Element.prototype.attr end!-//

//-!nv.$Element.prototype.width start!-//
/**
 	width() �޼���� HTML ����� ���� �ʺ� �����´�.
	
	@method width
	@return {Number} HTML ����� ���� �ʺ�(Number)��  ��ȯ�Ѵ�.
	@remark ���������� Box ���� ũ�� ��� ����� �ٸ��Ƿ� CSS�� width �Ӽ� ���� width �޼���()�� ��ȯ ���� ���� �ٸ� �� �ִ�.
	@see nv.$Element#height
	@example
		<style type="text/css">
			div { width:70px; height:50px; padding:5px; margin:5px; background:red; }
		</style>
		
		<div id="sample_div"></div>
		
		// ��ȸ
		$Element("sample_div").width();	// 80
 */
/**
 	width() �޼���� HTML ����� �ʺ� �����Ѵ�.
	
	@method width
	@param {Numeric} nWidth	������ �ʺ� ��. ������ �ȼ�(px)�̸� �Ķ������ ���� ���ڷ� �����Ѵ�.
	@return {this} width �Ӽ� ���� �ݿ��� �ν��Ͻ� �ڽ�
	@remark ���������� Box ���� ũ�� ��� ����� �ٸ��Ƿ� CSS�� width �Ӽ� ���� width �޼���()�� ��ȯ ���� ���� �ٸ� �� �ִ�.
	@see nv.$Element#height
	@example
		// HTML ��ҿ� �ʺ� ���� ����
		$Element("sample_div").width(200);
		
		//Before
		<style type="text/css">
			div { width:70px; height:50px; padding:5px; margin:5px; background:red; }
		</style>
		
		<div id="sample_div"></div>
		
		//After
		<div id="sample_div" style="width: 190px"></div>
 */
nv.$Element.prototype.width = function(width) {
    //-@@$Element.width-@@//
    var oArgs = g_checkVarType(arguments, {
        'g' : [  ],
        's' : ["nWidth:Numeric"]
    },"$Element#width");
    
    switch(oArgs+""){
        case "g" :
            
            return this._element.offsetWidth;
            
        case "s" :
            
            width = oArgs.nWidth;
            var e = this._element;
            e.style.width = width+"px";
            var off = e.offsetWidth;
            if (off != width && off!==0) {
                var w = (width*2 - off);
                if (w>0)
                    e.style.width = w + "px";
            }
            return this;
            
    }

};
//-!nv.$Element.prototype.width end!-//

//-!nv.$Element.prototype.height start!-//
/**
 	height() �޼���� HTML ����� ���� ���̸� �����´�.
	
	@method height
	@return {Number} HTML ����� ���� ����(Number)�� ��ȯ�Ѵ�.
	@remark ���������� Box ���� ũ�� ��� ����� �ٸ��Ƿ� CSS�� height �Ӽ� ���� height() �޼����� ��ȯ ���� ���� �ٸ� �� �ִ�.
	@see nv.$Element#width
	@example
		<style type="text/css">
			div { width:70px; height:50px; padding:5px; margin:5px; background:red; }
		</style>
		
		<div id="sample_div"></div>
		
		// ��ȸ
		$Element("sample_div").height(); // 60
 */
/**
 	height() �޼���� HTML ����� ���� ���̸� �����Ѵ�.
	
	@method height
	@param {Number} nHeight ������ ���� ��. ������ �ȼ�(px)�̸� �Ķ������ ���� ���ڷ� �����Ѵ�.
	@return {this} height �Ӽ� ���� �ݿ��� �ν��Ͻ� �ڽ�
	@remark ���������� Box ���� ũ�� ��� ����� �ٸ��Ƿ� CSS�� height �Ӽ� ���� height() �޼����� ��ȯ ���� ���� �ٸ� �� �ִ�.
	@see nv.$Element#width
	@example
		// HTML ��ҿ� ���� ���� ����
		$Element("sample_div").height(100);
		
		//Before
		<style type="text/css">
			div { width:70px; height:50px; padding:5px; margin:5px; background:red; }
		</style>
		
		<div id="sample_div"></div>
		
		//After
		<div id="sample_div" style="height: 90px"></div>
 */
nv.$Element.prototype.height = function(height) {
    //-@@$Element.height-@@//
    var oArgs = g_checkVarType(arguments, {
        'g' : [  ],
        's' : ["nHeight:Numeric"]
    },"$Element#height");
    
    switch(oArgs+""){
        case "g" :
            return this._element.offsetHeight;
            
        case "s" :
            height = oArgs.nHeight;
            var e = this._element;
            e.style.height = height+"px";
            var off = e.offsetHeight;
            if (off != height && off!==0) {
                var height = (height*2 - off);
                if(height>0)
                    e.style.height = height + "px";
            }
            return this;
            
    }
};
//-!nv.$Element.prototype.height end!-//

//-!nv.$Element.prototype.className start!-//
/**
 	className() �޼���� HTML ����� Ŭ���� �̸��� Ȯ���Ѵ�.
	
	@method className
	@return {String} Ŭ���� �̸��� ��ȯ. �ϳ� �̻��� Ŭ������ ������ ��� �������� ���е� ���ڿ��� ��ȯ�ȴ�.
	@see nv.$Element#hasClass
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@see nv.$Element#toggleClass
	@example
		<style type="text/css">
		p { margin: 8px; font-size:16px; }
		.selected { color:#0077FF; }
		.highlight { background:#C6E746; }
		</style>
		
		<p>Hello and <span id="sample_span" class="selected">Goodbye</span></p>
		
		// Ŭ���� �̸� ��ȸ
		$Element("sample_span").className(); // selected
 */
/**
 	className() �޼���� HTML ����� Ŭ���� �̸��� �����Ѵ�.
	
	@method className
	@param {String+} sClass ������ Ŭ���� �̸�. �ϳ� �̻��� Ŭ������ �����Ϸ��� �������� �����Ͽ� ������ Ŭ���� �̸��� �����Ѵ�.
	@return {this} ������ Ŭ������ �ݿ��� �ν��Ͻ� �ڽ�
	@throws {nv.$Except.NOT_FOUND_ARGUMENT} �Ķ���Ͱ� ���� ���.
	@see nv.$Element#hasClass
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@see nv.$Element#toggleClass
	@example
		// HTML ��ҿ� Ŭ���� �̸� ����
		$Element("sample_span").className("highlight");
		
		//Before
		<style type="text/css">
		p { margin: 8px; font-size:16px; }
		.selected { color:#0077FF; }
		.highlight { background:#C6E746; }
		</style>
		
		<p>Hello and <span id="sample_span" class="selected">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span" class="highlight">Goodbye</span></p>
 */
nv.$Element.prototype.className = function(sClass) {
    //-@@$Element.className-@@//
    var oArgs = g_checkVarType(arguments, {
        'g' : [  ],
        's' : [nv.$Jindo._F("sClass:String+")]
    },"$Element#className");
    var e = this._element;
    switch(oArgs+"") {
        case "g":
            return e.className;
        case "s":
            e.className = sClass;
            return this;
            
    }

};
//-!nv.$Element.prototype.className end!-//

//-!nv.$Element.prototype.hasClass start!-//
/**
 	hasClass() �޼���� HTML ��ҿ��� Ư�� Ŭ������ ����ϰ� �ִ��� Ȯ���Ѵ�.
	
	@method hasClass
	@param {String+} sClass Ȯ���� Ŭ���� �̸�.
	@return {Boolean} ������ Ŭ������ ��� ����.
	@see nv.$Element#className
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@see nv.$Element#toggleClass
	@example
		<style type="text/css">
			p { margin: 8px; font-size:16px; }
			.selected { color:#0077FF; }
			.highlight { background:#C6E746; }
		</style>
		
		<p>Hello and <span id="sample_span" class="selected highlight">Goodbye</span></p>
		
		// Ŭ������ ��뿩�θ� Ȯ��
		var welSample = $Element("sample_span");
		welSample.hasClass("selected"); 			// true
		welSample.hasClass("highlight"); 			// true
 */
nv.$Element.prototype.hasClass = function(sClass) {
    //-@@$Element.hasClass-@@//
    var ___checkVarType = g_checkVarType;

    if(nv._p_.canUseClassList()){
        nv.$Element.prototype.hasClass = function(sClass){
            var oArgs = ___checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#hasClass");
            return this._element.classList.contains(sClass);
        };
    } else {
        nv.$Element.prototype.hasClass = function(sClass){
            var oArgs = ___checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#hasClass");
            return (" "+this._element.className+" ").indexOf(" "+sClass+" ") > -1;
        };
    }
    return this.hasClass.apply(this,arguments);
};
//-!nv.$Element.prototype.hasClass end!-//

//-!nv.$Element.prototype.addClass start!-//
/**
 	addClass() �޼���� HTML ��ҿ� Ŭ������ �߰��Ѵ�.
	
	@method addClass
	@param {String+} sClass �߰��� Ŭ���� �̸�. �� �̻��� Ŭ������ �߰��Ϸ��� Ŭ���� �̸��� �������� �����Ͽ� �����Ѵ�.
	@return {this} ������ Ŭ������ �߰��� �ν��Ͻ� �ڽ�
	@see nv.$Element#className
	@see nv.$Element#hasClass
	@see nv.$Element#removeClass
	@see nv.$Element#toggleClass
	@example
		// Ŭ���� �߰�
		$Element("sample_span1").addClass("selected");
		$Element("sample_span2").addClass("selected highlight");
		
		//Before
		<p>Hello and <span id="sample_span1">Goodbye</span></p>
		<p>Hello and <span id="sample_span2">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span1" class="selected">Goodbye</span></p>
		<p>Hello and <span id="sample_span2" class="selected highlight">Goodbye</span></p>
 */
nv.$Element.prototype.addClass = function(sClass) {
    //-@@$Element.addClass-@@//
    if(this._element.classList){
        nv.$Element.prototype.addClass = function(sClass) {
            if(this._element==null) return this;
            var oArgs = g_checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#addClass");
         
            var aClass = (sClass+"").split(/\s+/);
            var flistApi = this._element.classList;
            for(var i = aClass.length ; i-- ;) {
                aClass[i]!=""&&flistApi.add(aClass[i]);
            }
            return this;
        };
    } else {
        nv.$Element.prototype.addClass = function(sClass) {
            var oArgs = g_checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#addClass");
            var e = this._element;
            var sClassName = e.className;
            var aClass = (sClass+"").split(" ");
            var sEachClass;
            for (var i = aClass.length - 1; i >= 0 ; i--){
                sEachClass = aClass[i];
                if ((" "+sClassName+" ").indexOf(" "+sEachClass+" ") == -1) {
                    sClassName = sClassName+" "+sEachClass;
                }
            }
            e.className = sClassName.replace(/\s+$/, "").replace(/^\s+/, "");
            return this;
        };
    }
    return this.addClass.apply(this,arguments);
};
//-!nv.$Element.prototype.addClass end!-//

//-!nv.$Element.prototype.removeClass start!-//
/**
 	removeClass() �޼���� HTML ��ҿ��� Ư�� Ŭ������ �����Ѵ�.
	
	@method removeClass
	@param {String+} sClass ������ Ŭ���� �̸�. �� �̻��� Ŭ������ �����Ϸ��� Ŭ���� �̸��� �������� �����Ͽ� �����Ѵ�.
	@return {this} ������ Ŭ������ ������ �ν��Ͻ� �ڽ�
	@see nv.$Element#className
	@see nv.$Element#hasClass
	@see nv.$Element#addClass
	@see nv.$Element#toggleClass
	@example
		// Ŭ���� ����
		$Element("sample_span").removeClass("selected");
		
		//Before
		<p>Hello and <span id="sample_span" class="selected highlight">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span" class="highlight">Goodbye</span></p>
	@example
		// �������� Ŭ������ ����
		$Element("sample_span").removeClass("selected highlight");
		$Element("sample_span").removeClass("highlight selected");
		
		//Before
		<p>Hello and <span id="sample_span" class="selected highlight">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span" class="">Goodbye</span></p> 
 */
nv.$Element.prototype.removeClass = function(sClass) {
    //-@@$Element.removeClass-@@//
 	if(this._element.classList) {
        nv.$Element.prototype.removeClass = function(sClass){
            var oArgs = g_checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#removeClass");
            if(this._element==null) return this;
            var flistApi = this._element.classList;
            var aClass = (sClass+"").split(" ");
            for(var i = aClass.length ; i-- ;){
                aClass[i]!=""&&flistApi.remove(aClass[i]);
            }
            return this;
        };
 	} else {
        nv.$Element.prototype.removeClass = function(sClass) {
            var oArgs = g_checkVarType(arguments, {
                '4str' : ["sClass:String+"]
            },"$Element#removeClass");
            var e = this._element;
            var sClassName = e.className;
            var aClass = (sClass+"").split(" ");
            var sEachClass;

            for (var i = aClass.length - 1; i >= 0; i--){
                if(/\W/g.test(aClass[i])) {
                     aClass[i] = aClass[i].replace(/(\W)/g,"\\$1");
                }

                sClassName = (" "+sClassName+" ").replace(new RegExp("\\s+"+ aClass[i] +"(?=\\s+)","g")," ");
            }
            
            e.className = sClassName.replace(/\s+$/, "").replace(/^\s+/, "");

            return this;
        };
 	}
	return this.removeClass.apply(this,arguments);
};
//-!nv.$Element.prototype.removeClass end!-//

//-!nv.$Element.prototype.toggleClass start(nv.$Element.prototype.addClass,nv.$Element.prototype.removeClass,nv.$Element.prototype.hasClass)!-//
/**
 	toggleClass() �޼���� HTML ��ҿ� �Ķ���ͷ� ������ Ŭ������ �̹� ����Ǿ� ������ �����ϰ� ���� ������ �߰��Ѵ�.<br>
	�Ķ���͸� �ϳ��� �Է��� ��� �Ķ���ͷ� ������ Ŭ������ ���ǰ� ������ �����ϰ� ���ǰ� ���� ������ �߰��Ѵ�. ���� �� ���� �Ķ���͸� �Է��� ��� �� Ŭ���� �߿��� ����ϰ� �ִ� ���� �����ϰ� ������ Ŭ������ �߰��Ѵ�.
	
	@method toggleClass
	@param {String+} sClass �߰� Ȥ�� ������ Ŭ���� �̸�1.
	@param {String+} [sClass2] �߰� Ȥ�� ������ Ŭ���� �̸�2.
	@return {this} ������ Ŭ������ �߰� Ȥ�� ������ �ν��Ͻ� �ڽ�
	@import core.$Element[hasClass,addClass,removeClass]
	@see nv.$Element#className
	@see nv.$Element#hasClass
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@example
		// �Ķ���Ͱ� �ϳ��� ���
		$Element("sample_span1").toggleClass("highlight");
		$Element("sample_span2").toggleClass("highlight");
		
		//Before
		<p>Hello and <span id="sample_span1" class="selected highlight">Goodbye</span></p>
		<p>Hello and <span id="sample_span2" class="selected">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span1" class="selected">Goodbye</span></p>
		<p>Hello and <span id="sample_span2" class="selected highlight">Goodbye</span></p>
	@example
		// �Ķ���Ͱ� �� ���� ���
		$Element("sample_span1").toggleClass("selected", "highlight");
		$Element("sample_span2").toggleClass("selected", "highlight");
		
		//Before
		<p>Hello and <span id="sample_span1" class="highlight">Goodbye</span></p>
		<p>Hello and <span id="sample_span2" class="selected">Goodbye</span></p>
		
		//After
		<p>Hello and <span id="sample_span1" class="selected">Goodbye</span></p>
		<p>Hello and <span id="sample_span2" class="highlight">Goodbye</span></p> 
 */
nv.$Element.prototype.toggleClass = function(sClass, sClass2) {
    //-@@$Element.toggleClass-@@//
    var ___checkVarType = g_checkVarType;
    if(nv._p_.canUseClassList()){
        nv.$Element.prototype.toggleClass = function(sClass, sClass2){
            var oArgs = ___checkVarType(arguments, {
                '4str'  : ["sClass:String+"],
                '4str2' : ["sClass:String+", "sClass2:String+"]
            },"$Element#toggleClass");
            
            switch(oArgs+"") {
                case '4str':
                    this._element.classList.toggle(sClass+"");
                    break;
                case '4str2':
                    sClass = sClass+"";
                    sClass2 = sClass2+"";
                    if(this.hasClass(sClass)){
                        this.removeClass(sClass);
                        this.addClass(sClass2);
                    }else{
                        this.addClass(sClass);
                        this.removeClass(sClass2);
                    }
                    
            }
            return this;
        };
    } else {
        nv.$Element.prototype.toggleClass = function(sClass, sClass2){
            var oArgs = ___checkVarType(arguments, {
                '4str'  : ["sClass:String+"],
                '4str2' : ["sClass:String+", "sClass2:String+"]
            },"$Element#toggleClass");
            
            sClass2 = sClass2 || "";
            if (this.hasClass(sClass)) {
                this.removeClass(sClass);
                if (sClass2) this.addClass(sClass2);
            } else {
                this.addClass(sClass);
                if (sClass2) this.removeClass(sClass2);
            }

            return this;
        };
    }
    return this.toggleClass.apply(this,arguments);
};
//-!nv.$Element.prototype.toggleClass end!-//

//-!nv.$Element.prototype.cssClass start(nv.$Element.prototype.addClass,nv.$Element.prototype.removeClass,nv.$Element.prototype.hasClass)!-//
/**
 	cssClass�� Ŭ������ ������ Ȯ���Ѵ�.
	
	@method cssClass
	@param {String+} sName class��
	@return {Boolean} �ش� Ŭ������ �ִ��� ������ �Ҹ� ���� ��ȯ�Ѵ�.
	@since 2.0.0
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@example
		// ù ��° �Ķ���͸� ���� ���
		<div id="sample_span1"/>
		$Element("sample_span1").cssClass("highlight");// false
 */
/**
 	cssClass�� Ŭ������ �߰�, ������ �� �ִ�.
	
	@method cssClass
	@syntax sName, bClassType
	@syntax oList
	@param {String+} sName class��,
	@param {Boolean} bClassType true�� ���� Ŭ������ �߰��ϰ� false�� ���� Ŭ������ �����Ѵ�.
	@param {Hash+} oList �ϳ� �̻��� �Ӽ���� �Ҹ����� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} ������ Ŭ������ �߰�/������ �ν��Ͻ� �ڽ�
	@since 2.0.0
	@see nv.$Element#addClass
	@see nv.$Element#removeClass
	@example
		// �� ��° �Ķ���͵� ���� ���.
		$Element("sample_span1").cssClass("highlight",true);
		-> <div id="sample_span1" class="highlight"/>
		
		$Element("sample_span1").cssClass("highlight",false);
		-> <div id="sample_span1" class=""/>
	@example
		// ù ��° �Ķ���͸� ������Ʈ�� ���� ���.
		<div id="sample_span1" class="bar"/>
		
		$Element("sample_span1").cssClass({
			"foo": true,
			"bar" : false
		});
		-> <div id="sample_span1" class="foo"/>
 */
nv.$Element.prototype.cssClass = function(vClass, bCondition){
    var oArgs = g_checkVarType(arguments, {
        'g'  : ["sClass:String+"],
        's4bln' : ["sClass:String+", "bCondition:Boolean"],
        's4obj' : ["oObj:Hash+"]
    },"$Element#cssClass");
            
    switch(oArgs+""){
        case "g":
            return this.hasClass(oArgs.sClass);
            
        case "s4bln":
            if(oArgs.bCondition){
                this.addClass(oArgs.sClass);
            }else{
                this.removeClass(oArgs.sClass);
            }
            return this;
            
        case "s4obj":
            var e = this._element;
            vClass = oArgs.oObj;
            var sClassName = e.className;
            for(var sEachClass in vClass){
                if (vClass.hasOwnProperty(sEachClass)) {
                    if(vClass[sEachClass]){
                        if ((" " + sClassName + " ").indexOf(" " + sEachClass + " ") == -1) {
                            sClassName = (sClassName+" "+sEachClass).replace(/^\s+/, "");
                        }
                    }else{
                        if ((" " + sClassName + " ").indexOf(" " + sEachClass + " ") > -1) {
                            sClassName = (" "+sClassName+" ").replace(" "+sEachClass+" ", " ").replace(/\s+$/, "").replace(/^\s+/, "");
                        }
                    }
                }
            }
            e.className = sClassName;
            return this;
            
    }


};  
    
//-!nv.$Element.prototype.cssClass end!-//
//-!nv.$Element.prototype.text start!-//
/**
 	text() �޼���� HTML ����� �ؽ�Ʈ ��� ���� �����´�.
	
	@method text
	@return {String} HTML ����� �ؽ�Ʈ ���(String)�� ��ȯ.
	@example
		<ul id="sample_ul">
			<li>�ϳ�</li>
			<li>��</li>
			<li>��</li>
			<li>��</li>
		</ul>
		
		// �ؽ�Ʈ ��� �� ��ȸ
		$Element("sample_ul").text();
		// ���
		//	�ϳ�
		//	��
		//	��
		//	��
 */
/**
 	text() �޼���� HTML ����� �ؽ�Ʈ ��带 ������ ������ �����Ѵ�.
	
	@method text
	@param {String+} sText ������ �ؽ�Ʈ.
	@return {this} ������ ���� ������ �ν��Ͻ� �ڽ�
	@example
		// �ؽ�Ʈ ��� �� ����
		$Element("sample_ul").text('�ټ�');
		
		//Before
		<ul id="sample_ul">
			<li>�ϳ�</li>
			<li>��</li>
			<li>��</li>
			<li>��</li>
		</ul>
		
		//After
		<ul id="sample_ul">�ټ�</ul>
	@example
		// �ؽ�Ʈ ��� �� ����
		$Element("sample_p").text("New Content");
		
		//Before
		<p id="sample_p">
			Old Content
		</p>
		
		//After
		<p id="sample_p">
			New Content
		</p>
 */
nv.$Element.prototype.text = function(sText) {
    //-@@$Element.text-@@//
    var oArgs = g_checkVarType(arguments, {
        'g'  : [],
        's4str' : ["sText:String+"],
        's4num' : [nv.$Jindo._F("sText:Numeric")],
        's4bln' : ["sText:Boolean"]
    },"$Element#text"),
        ele = this._element,
        tag = this.tag,
        prop,
        oDoc;
    
    switch(oArgs+""){
        case "g":
            prop = (ele.textContent !== undefined) ? "textContent" : "innerText";
            
            if(tag == "textarea" || tag == "input"){
                prop = "value";
            }
            
            return ele[prop];
        case "s4str":
        case "s4num":
        case "s4bln":
            try{
                /*
                  * Opera 11.01���� textContext�� Get�϶� ���������� �������� ����. �׷��� get�� ���� innerText�� ����ϰ� set�ϴ� ���� textContent�� ����Ѵ�.(http://devcafe.nhncorp.com/ajaxui/295768)
                 */ 
                if (tag == "textarea" || tag == "input"){
                    ele.value = sText + "";
                }else{
                    var oDoc = ele.ownerDocument || ele.document || document;
                    this.empty();
                    ele.appendChild(oDoc.createTextNode(sText));
                }
            }catch(e){
                return ele.innerHTML = (sText + "").replace(/&/g, '&amp;').replace(/</g, '&lt;');
            }
            
            return this;
    }
};
//-!nv.$Element.prototype.text end!-//

//-!nv.$Element.prototype.html start!-//
/**
 	html() �޼���� HTML ����� ���� HTML �ڵ�(innerHTML)�� �����´�.
	
	@method html
	@return {String} ���� HTML(String)�� ��ȯ. 
	@see https://developer.mozilla.org/en/DOM/element.innerHTML element.innerHTML - MDN Docs
	@see nv.$Element#outerHTML
	@example
		<div id="sample_container">
			<p><em>Old</em> content</p>
		</div>
		
		// ���� HTML ��ȸ
		$Element("sample_container").html(); // <p><em>Old</em> content</p>
 */
/**
 	html() �޼���� HTML ����� ���� HTML �ڵ�(innerHTML)�� �����Ѵ�. �̶� ��� ���� ����� ��� �̺�Ʈ �ڵ鷯�� �����Ѵ�.
	
	@method html
	@param {String+} sHTML ���� HTML �ڵ�� ������ HTML ���ڿ�.
	@return {this} ������ ���� ������ �ν��Ͻ� �ڽ�
	@remark IE8���� colgroup�� col�� �����Ϸ��� �� �� colgroup�� �����ϰ� �ٽ� ���� �� col�� �߰��ؾ� �մϴ�.
	@see https://developer.mozilla.org/en/DOM/element.innerHTML element.innerHTML - MDN Docs
	@see nv.$Element#outerHTML
	@example
		// ���� HTML ����
		$Element("sample_container").html("<p>New <em>content</em></p>");
		
		//Before
		<div id="sample_container">
		 	<p><em>Old</em> content</p>
		</div>
		
		//After
		<div id="sample_container">
		 	<p>New <em>content</em></p>
		</div>
 */
nv.$Element.prototype.html = function(sHTML) {
    //-@@$Element.html-@@//
    var isIe = nv._p_._JINDO_IS_IE;
    var isFF = nv._p_._JINDO_IS_FF;
    var _param = {
                'g'  : [],
                's4str' : [nv.$Jindo._F("sText:String+")],
                's4num' : ["sText:Numeric"],
                's4bln' : ["sText:Boolean"]
    };
    var ___checkVarType = g_checkVarType;
    
    if (isIe) {
        nv.$Element.prototype.html = function(sHTML){
            var oArgs = ___checkVarType(arguments,_param,"$Element#html");
            switch(oArgs+""){
                case "g":
                    return this._element.innerHTML;
                case "s4str":
                case "s4num":
                case "s4bln":
                    sHTML += "";
                    if(nv.cssquery) nv.cssquery.release();
                    var oEl = this._element;
    
                    while(oEl.firstChild){
                        oEl.removeChild(oEl.firstChild);
                    }
                    /*
                      * IE �� FireFox �� �Ϻ� ��Ȳ���� SELECT �±׳� TABLE, TR, THEAD, TBODY �±׿� innerHTML �� �����ص�
 * ������ ������ �ʵ��� ���� - hooriza
                     */
                    var sId = 'R' + new Date().getTime() + parseInt(Math.random() * 100000,10);
                    var oDoc = oEl.ownerDocument || oEl.document || document;
    
                    var oDummy;
                    var sTag = oEl.tagName.toLowerCase();
    
                    switch (sTag) {
                        case 'select':
                        case 'table':
                            oDummy = oDoc.createElement("div");
                            oDummy.innerHTML = '<' + sTag + ' class="' + sId + '">' + sHTML + '</' + sTag + '>';
                            break;
                        case 'tr':
                        case 'thead':
                        case 'tbody':
                        case 'colgroup':
                            oDummy = oDoc.createElement("div");
                            oDummy.innerHTML = '<table><' + sTag + ' class="' + sId + '">' + sHTML + '</' + sTag + '></table>';
                            break;
        
                        default:
                            oEl.innerHTML = sHTML;
                            
                    }
    
                    if (oDummy) {
    
                        var oFound;
                        for (oFound = oDummy.firstChild; oFound; oFound = oFound.firstChild)
                            if (oFound.className == sId) break;
    
                        if (oFound) {
                            var notYetSelected = true;
                            for (var oChild; oChild = oEl.firstChild;) oChild.removeNode(true); // innerHTML = '';
    
                            for (var oChild = oFound.firstChild; oChild; oChild = oFound.firstChild){
                                if(sTag=='select'){
                                    /*
                                     * ie���� select�ױ��� ��� option�� selected�� �Ǿ� �ִ� option�� �ִ� ��� �߰���
* selected�� �Ǿ� ������ �� ���� ���ʹ� ��� selected�� true�� �Ǿ� �־�
* �ذ��ϱ� ���� cloneNode�� �̿��Ͽ� option�� ī���� �� selected�� ������. - mixed
                                     */
                                    var cloneNode = oChild.cloneNode(true);
                                    if (oChild.selected && notYetSelected) {
                                        notYetSelected = false;
                                        cloneNode.selected = true;
                                    }
                                    oEl.appendChild(cloneNode);
                                    oChild.removeNode(true);
                                }else{
                                    oEl.appendChild(oChild);
                                }
    
                            }
                            oDummy.removeNode && oDummy.removeNode(true);
    
                        }
    
                        oDummy = null;
    
                    }
    
                    return this;
                    
            }
        };
    }else if(isFF){
        nv.$Element.prototype.html = function(sHTML){
            var oArgs = ___checkVarType(arguments,_param,"$Element#html");
            
            switch(oArgs+""){
                case "g":
                    return this._element.innerHTML;
                    
                case "s4str":
                case "s4num":
                case "s4bln":
                	// nv._p_.releaseEventHandlerForAllChildren(this);
                	
                    sHTML += ""; 
                    var oEl = this._element;
                    
                    if(!oEl.parentNode){
                        /*
                         {{html_1}}
                         */
                        var sId = 'R' + new Date().getTime() + parseInt(Math.random() * 100000,10);
                        var oDoc = oEl.ownerDocument || oEl.document || document;
    
                        var oDummy;
                        var sTag = oEl.tagName.toLowerCase();
    
                        switch (sTag) {
                        case 'select':
                        case 'table':
                            oDummy = oDoc.createElement("div");
                            oDummy.innerHTML = '<' + sTag + ' class="' + sId + '">' + sHTML + '</' + sTag + '>';
                            break;
    
                        case 'tr':
                        case 'thead':
                        case 'tbody':
                        case 'colgroup':
                            oDummy = oDoc.createElement("div");
                            oDummy.innerHTML = '<table><' + sTag + ' class="' + sId + '">' + sHTML + '</' + sTag + '></table>';
                            break;
    
                        default:
                            oEl.innerHTML = sHTML;
                            
                        }
    
                        if (oDummy) {
                            var oFound;
                            for (oFound = oDummy.firstChild; oFound; oFound = oFound.firstChild)
                                if (oFound.className == sId) break;
    
                            if (oFound) {
                                for (var oChild; oChild = oEl.firstChild;) oChild.removeNode(true); // innerHTML = '';
    
                                for (var oChild = oFound.firstChild; oChild; oChild = oFound.firstChild){
                                    oEl.appendChild(oChild);
                                }
    
                                oDummy.removeNode && oDummy.removeNode(true);
    
                            }
    
                            oDummy = null;
    
                        }
                    }else{
                        oEl.innerHTML = sHTML;
                    }
                    
    
                    return this;
                    
            }
        };
    }else{
        nv.$Element.prototype.html = function(sHTML){
            var oArgs = ___checkVarType(arguments,_param,"$Element#html");
            
            switch(oArgs+""){
                case "g":
                    return this._element.innerHTML;
                    
                case "s4str":
                case "s4num":
                case "s4bln":
                	// nv._p_.releaseEventHandlerForAllChildren(this);
                	
                    sHTML += ""; 
                    var oEl = this._element;
                    oEl.innerHTML = sHTML;
                    return this;
                    
            }
            
        };
    }
    
    return this.html.apply(this,arguments);
};
//-!nv.$Element.prototype.html end!-//

//-!nv.$Element.prototype.outerHTML start!-//
/**
 	outerHTML() �޼���� HTML ����� ���� �ڵ�(innerHTML)�� �ش��ϴ� �κа� �ڽ��� �±׸� ������ HTML �ڵ带 ��ȯ�Ѵ�.
	
	@method outerHTML
	@return {String} HTML �ڵ�.
	@see nv.$Element#html
	@example
		<h2 id="sample0">Today is...</h2>
		
		<div id="sample1">
		  	<p><span id="sample2">Sample</span> content</p>
		</div>
		
		// �ܺ� HTML ���� ��ȸ
		$Element("sample0").outerHTML(); // <h2 id="sample0">Today is...</h2>
		$Element("sample1").outerHTML(); // <div id="sample1">  <p><span id="sample2">Sample</span> content</p>  </div>
		$Element("sample2").outerHTML(); // <span id="sample2">Sample</span>
 */
nv.$Element.prototype.outerHTML = function() {
    //-@@$Element.outerHTML-@@//
    var e = this._element;
    e = nv.$Jindo.isDocument(e)?e.documentElement:e;
    if (e.outerHTML !== undefined) return e.outerHTML;
    
    var oDoc = e.ownerDocument || e.document || document;
    var div = oDoc.createElement("div");
    var par = e.parentNode;

    /**
            ������尡 ������ innerHTML��ȯ
     */
    if(!par) return e.innerHTML;

    par.insertBefore(div, e);
    div.style.display = "none";
    div.appendChild(e);

    var s = div.innerHTML;
    par.insertBefore(e, div);
    par.removeChild(div);

    return s;
};
//-!nv.$Element.prototype.outerHTML end!-//

//-!nv.$Element.prototype.toString start(nv.$Element.prototype.outerHTML)!-//
/**
 	toString() �޼���� �ش� ����� �ڵ带 ���ڿ��� ��ȯ�Ͽ� ��ȯ�Ѵ�(outerHTML �޼���� ����).
	
	@method toString
	@return {String} HTML �ڵ�.
	@see nv.$Element#outerHTML
 */
nv.$Element.prototype.toString = function(){
    return this.outerHTML()||"[object $Element]";
};
//-!nv.$Element.prototype.toString end!-//

//-!nv.$Element.prototype.attach start(nv.$Element.prototype.isEqual,nv.$Element.prototype.isChildOf,nv.$Element.prototype.detach, nv.$Element.event_etc, nv.$Element.domready, nv.$Element.unload, nv.$Event)!-//
/**
 	attach() �޼���� ������Ʈ�� �̺�Ʈ�� �Ҵ��Ѵ�.
	@syntax sEvent, fpCallback
	@syntax oList
	@method attach
	@param {String+} sEvent �̺�Ʈ ��
		<ul class="disc">
			<li>�̺�Ʈ �̸����� on ���ξ ������� �ʴ´�.</li>
			<li>���콺 �� ��ũ�� �̺�Ʈ�� mousewheel �� ����Ѵ�.</li>
			<li>�⺻ �̺�Ʈ �ܿ� �߰��� ����� ������ �̺�Ʈ�� domready, mouseenter, mouseleave, mousewheel�� �ִ�.</li>
			<li>delegate�� ����� �߰��� (@�� �����ڷ� selector�� ���� ����� �� �ִ�.)</li>
		</ul>
	@param {Function+} fpCallback �̺�Ʈ�� �߻����� �� ����Ǵ� �ݹ��Լ�.
	@param {Hash+} oList �ϳ� �̻��� �̺�Ʈ��� �Լ��� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} �̺�Ʈ�� �Ҵ��� �ν��Ͻ� �ڽ�
	@throws {nv.$Except.NOT_WORK_DOMREADY} IE�� ��� ������ �ȿ����� domready�Լ��� ����� ��.
	@since 2.0.0
	@remark 2.2.0 ��������, load�� domready�̺�Ʈ�� ���� Window�� Document���� �߻��ϴ� �̺�Ʈ������ ���θ� �����ؼ� ����Ͽ��� �̺�Ʈ�� �ùٸ��� �߻��Ѵ�.
	@remark 2.5.0 �������� @�� �����ڷ� delegateó�� ����� �� �ִ�.
	@see nv.$Element#detach
	@see nv.$Element#delegate
	@see nv.$Element#undelegate
	@example
		function normalEvent(e){
			alert("click");
		}
		function groupEvent(e){
			alert("group click");
		}
		
		//�Ϲ����� �̺�Ʈ �Ҵ�.
		$Element("some_id").attach("click",normalEvent);
	@example
		function normalEvent(e){
			alert("click");
		}
		
		//delegateó�� ����ϱ� ���ؼ��� @�� �����ڷ� ��밡��.
		$Element("some_id").attach("click@.selected",normalEvent);
		
		
		$Element("some_id").attach({
			"click@.selected":normalEvent,
			"click@.checked":normalEvent2,
			"click@.something":normalEvent3
		});
	@example
		function loadHandler(e){
			// empty
		}
		function domreadyHandler(e){
			// empty
		}
		var welDoc = $Element(document);
		var welWin = $Element(window);
		
		// document�� load �̺�Ʈ �ڵ鷯 ���
		welDoc.attach("load", loadHandler);
		welDoc.hasEventListener("load"); // true
		welWin.hasEventListener("load"); // true
		
		// detach�� document, window ����Ϳ��� �ص� �������.
		welDoc.detach("load", loadHandler);
		welDoc.hasEventListener("load"); // false
		welWin.hasEventListener("load"); // false
		
		// window�� domready �̺�Ʈ �ڵ鷯 ��???
		welWin.attach("domready", domreadyHandler);
		welWin.hasEventListener("domready"); // true
		welDoc.hasEventListener("domready"); // true
		
		// detach�� document, window ����Ϳ��� �ص� �������.
		welWin.detach("domready", domreadyHandler);
		welWin.hasEventListener("domready"); // false
		welDoc.hasEventListener("domready"); // false
 */   
nv.$Element.prototype.attach = function(sEvent, fpCallback){
    var oArgs = g_checkVarType(arguments, {
        '4str'  : ["sEvent:String+", "fpCallback:Function+"],
        '4obj'  : ["hListener:Hash+"]
    },"$Element#attach"), oSplit, hListener;
   
    switch(oArgs+""){
       case "4str":
            oSplit = nv._p_.splitEventSelector(oArgs.sEvent);
            this._add(oSplit.type,oSplit.event,oSplit.selector,fpCallback);
            break;
       case "4obj":
            hListener = oArgs.hListener;
            for(var i in hListener){
                this.attach(i,hListener[i]);
            }
            break;
    }
    return this;
};
//-!nv.$Element.prototype.attach end!-//

//-!nv.$Element.prototype.detach start(nv.$Element.prototype.attach)!-//
/**
 	detach() �޼���� ������Ʈ�� ��ϵ� �̺�Ʈ �ڵ鷯�� ��� �����Ѵ�.
	@syntax sEvent, fpCallback
	@syntax oList
	@method detach
	@param {String+} sEvent �̺�Ʈ ��
	@param {Function+} fpCallback �̺�Ʈ�� �߻����� �� ����Ǵ� �ݹ��Լ�.
	@param {Hash+} oList �ϳ� �̻��� �̺�Ʈ��� �Լ��� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} �̺�Ʈ �ڵ鷯�� ��� ������ �ν��Ͻ� �ڽ�
	@remark 2.2.0 ��������, load�� domready�̺�Ʈ�� ���� Window�� Document���� �߻��ϴ� �̺�Ʈ������ ���θ� �����ؼ� ����Ͽ��� �̺�Ʈ�� �ùٸ��� �߻��Ѵ�.
	@remark 2.5.0 �������� @�� �����ڷ� delegateó�� ����� �� �ִ�.
	@see nv.$Element#detach
	@see nv.$Element#delegate
	@see nv.$Element#undelegate
	@since 2.0.0
	@example
		function normalEvent(e){
			alert("click");
		}
		function groupEvent(e){
			alert("group click");
		}
		function groupEvent2(e){
			alert("group2 click");
		}
		function groupEvent3(e){
			alert("group3 click");
		}
		
		//�Ϲ����� �̺�Ʈ �Ҵ�.
		$Element("some_id").attach("click",normalEvent);
		
		//�Ϲ����� �̺�Ʈ ����. �Ϲ����� �̺�Ʈ ������ �ݵ�� �Լ��� �־������ ������ �����ϴ�.
		$Element("some_id").detach("click",normalEvent);
   @example
		function normalEvent(e){
			alert("click");
		}
		
		//undelegateó�� ����ϱ� ���ؼ��� @�� �����ڷ� ��밡��.
		$Element("some_id").attach("click@.selected",normalEvent);
		$Element("some_id").detach("click@.selected",normalEvent);
 */
nv.$Element.prototype.detach = function(sEvent, fpCallback){
    var oArgs = g_checkVarType(arguments, {
        // 'group_for_string'  : ["sEvent:String+"],
        '4str'  : ["sEvent:String+", "fpCallback:Function+"],
        '4obj'  : ["hListener:Hash+"]
    },"$Element#detach"), oSplit, hListener;
   
    switch(oArgs+""){
       case "4str":
            oSplit = nv._p_.splitEventSelector(oArgs.sEvent);
            this._del(oSplit.type,oSplit.event,oSplit.selector,fpCallback);
            break;
       case "4obj":
            hListener = oArgs.hListener;
            for(var i in hListener){
                this.detach(i,hListener[i]);
            }
            break;
    }
    return this;
};
//-!nv.$Element.prototype.detach end!-//

//-!nv.$Element.prototype.delegate start(nv.$Element.prototype.undelegate, nv.$Element.event_etc, nv.$Element.domready, nv.$Element.unload, nv.$Event)!-//
/**
	delegate() �޼���� �̺�Ʈ ����(Event Deligation) ������� �̺�Ʈ�� ó���Ѵ�.<br>
	�̺�Ʈ �����̶�, �̺�Ʈ ������ �̿��Ͽ� �̺�Ʈ�� �����ϴ� ���� ��Ҹ� ���� �ξ� ȿ�������� �̺�Ʈ�� �����ϴ� ����̴�.
	
	@method delegate
	@param {String+} sEvent �̺�Ʈ �̸�. on ���ξ�� �����Ѵ�.
	@param {Variant} vFilter Ư�� HTML ��ҿ� ���ؼ��� �̺�Ʈ �ڵ鷯�� �����ϵ��� �ϱ� ���� ����.<br>
	���ʹ� CSS ������(String)�� �Լ�(Function)���� ������ �� �ִ�.
		<ul class="disc">
			<li>���ڿ��� �Է��ϸ� CSS �����ڷ� �̺�Ʈ �ڵ鷯�� �����ų ��Ҹ� ������ �� �ִ�.</li>
			<li>Boolean ���� ��ȯ�ϴ� �Լ��� �Ķ���� �Է��� �� �ִ�. �� �Լ��� ����� ��� �Լ��� true�� ��ȯ�� �� ������ �ݹ� �Լ�(fCallback)�� �Ķ���ͷ� �߰� �����ؾ� �Ѵ�.</li>
		</ul>
	@param {Function+} [fCallback] vFilter�� ������ �Լ��� true�� ��ȯ�ϴ� ��� ������ �ݹ� �Լ�.
	@return {this} �̺�Ʈ ������ ������ �ν��Ͻ� �ڽ�
	@remark 2.0.0����  domready, mousewheel, mouseleave, mouseenter �̺�Ʈ ��밡��.
	@since 1.4.6
	@see nv.$Element#attach
	@see nv.$Element#detach
	@see nv.$Element#undelegate
	@example
		<ul id="parent">
			<li class="odd">1</li>
			<li>2</li>
			<li class="odd">3</li>
			<li>4</li>
		</ul>
	
		// CSS �����͸� ���ͷ� ����ϴ� ���
		$Element("parent").delegate("click",
			".odd", 			// ����
			function(eEvent){	// �ݹ� �Լ�
				alert("odd Ŭ������ ���� li�� Ŭ�� �� �� ����");
			});
	@example
		<ul id="parent">
			<li class="odd">1</li>
			<li>2</li>
			<li class="odd">3</li>
			<li>4</li>
		</ul>
	
		// �Լ��� ���ͷ� ����ϴ� ���
		$Element("parent").delegate("click",
			function(oEle,oClickEle){	// ����
				return oClickEle.innerHTML == "2"
			},
			function(eEvent){			// �ݹ� �Լ�
				alert("Ŭ���� ����� innerHTML�� 2�� ��쿡 ����");
			});
*/
nv.$Element.prototype.delegate = function(sEvent , vFilter , fpCallback){
    var oArgs = g_checkVarType(arguments, {
        '4str'  : ["sEvent:String+", "vFilter:String+", "fpCallback:Function+"],
        '4fun'  : ["sEvent:String+", "vFilter:Function+", "fpCallback:Function+"]
    },"$Element#delegate");
    return this._add("delegate",sEvent,vFilter,fpCallback);
};
//-!nv.$Element.prototype.delegate end!-//

//-!nv.$Element.prototype.undelegate start(nv.$Element.prototype.delegate)!-//
/**
	undelegate() �޼���� delegate() �޼���� ����� �̺�Ʈ ������ �����Ѵ�.
	
	@method undelegate
	@param {String+} sEvent �̺�Ʈ ������ ����� �� ����� �̺�Ʈ �̸�. on ���ξ�� �����Ѵ�.
	@param {Variant} [vFilter] �̺�Ʈ ������ ����� �� ������ ����. �Ķ���͸� �Է����� ������ ������Ʈ�� delegate�� �Ҵ��� �̺�Ʈ �� Ư�� �̺�Ʈ�� ��� ������ �������.
	@param {Function+} [fCallback] �̺�Ʈ ������ ����� �� ������ �ݹ� �Լ�.
	@return {this} �̺�Ʈ ������ ������ �ν��Ͻ� �ڽ�
	@since 1.4.6
	@see nv.$Element#attach
	@see nv.$Element#detach
	@see nv.$Element#delegate
	@example
		<ul id="parent">
			<li class="odd">1</li>
			<li>2</li>
			<li class="odd">3</li>
			<li>4</li>
		</ul>
		
		// �ݹ� �Լ�
		function fnOddClass(eEvent){
			alert("odd Ŭ������ ���� li�� Ŭ�� �� �� ����");
		};
		function fnOddClass2(eEvent){
			alert("odd Ŭ������ ���� li�� Ŭ�� �� �� ����2");
		};
		function fnOddClass3(eEvent){
			alert("odd Ŭ������ ���� li�� Ŭ�� �� �� ����3");
		};
		
		// �̺�Ʈ �������̼� ���
		$Element("parent").delegate("click", ".odd", fnOddClass);
		
		// fnOddClass�� �̺�Ʈ ����
		$Element("parent").undelegate("click", ".odd", fnOddClass);
 */
nv.$Element.prototype.undelegate = function(sEvent , vFilter , fpCallback){
    var oArgs = g_checkVarType(arguments, {
        '4str'  : ["sEvent:String+", "vFilter:String+", "fpCallback:Function+"],
        '4fun'  : ["sEvent:String+", "vFilter:Function+", "fpCallback:Function+"],
        'group_for_string'  : ["sEvent:String+", "vFilter:String+"],
        'group_for_function'  : ["sEvent:String+", "vFilter:Function+"]
    },"$Element#undelegate");
    return this._del("delegate",sEvent,vFilter,fpCallback);
};
//-!nv.$Element.prototype.undelegate end!-//

//-!nv.$Element.event_etc.hidden start!-//
nv._p_.customEventAttach = function(sType,sEvent,vFilter,fpCallback,fpCallbackBind,eEle,fpAdd){
    if(!nv._p_.hasCustomEventListener(eEle.__nv__id,sEvent,vFilter)) {
        var CustomEvent = nv._p_.getCustomEvent(sEvent);
        var customInstance = new CustomEvent();
        var events = customInstance.events;
        
        customInstance.real_listener.push(fpCallback);
        customInstance.wrap_listener.push(fpCallbackBind);
        
        for(var i = 0, l = events.length ; i < l ; i++){
            customInstance["_fp"+events[i]] = nv.$Fn(customInstance[events[i]],customInstance).bind();
            fpAdd(sType, events[i], vFilter, customInstance["_fp"+events[i]]);
        }
        nv._p_.addCustomEventListener(eEle,eEle.__nv__id,sEvent,vFilter,customInstance);
    } else {
        var customInstance = nv._p_.getCustomEventListener(eEle.__nv__id, sEvent, vFilter).custom;
        if(customInstance.real_listener){
            customInstance.real_listener.push(fpCallback);
            customInstance.wrap_listener.push(fpCallbackBind);
        }
    }
};

nv._p_.normalCustomEventAttach = function(ele,sEvent,nv_id,vFilter,fpCallback,fpCallbackBind){
    if(!nv._p_.normalCustomEvent[sEvent][nv_id]){
        nv._p_.normalCustomEvent[sEvent][nv_id] = {};
        nv._p_.normalCustomEvent[sEvent][nv_id].ele = ele;
        nv._p_.normalCustomEvent[sEvent][nv_id][vFilter] = {};
        nv._p_.normalCustomEvent[sEvent][nv_id][vFilter].real_listener = [];
        nv._p_.normalCustomEvent[sEvent][nv_id][vFilter].wrap_listener = [];
    }
    nv._p_.normalCustomEvent[sEvent][nv_id][vFilter].real_listener.push(fpCallback);
    nv._p_.normalCustomEvent[sEvent][nv_id][vFilter].wrap_listener.push(fpCallbackBind);
};

/**
	�̺�Ʈ�� �߰��ϴ� ���� �Լ�.
	
	@method _add
	@ignore
	@param {String} sType delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
	@param {String} sEvent �̺�Ʈ��.
	@param {String | Function} vFilter ���� �Լ�.
	@param {Function} fpCallback �̺�Ʈ �ݹ��Լ�.
	@return {this} �ν��Ͻ� �ڽ�
 */

nv.$Element.prototype._add = function(sType, sEvent , vFilter , fpCallback){
    var oManager = nv.$Element.eventManager;
    var realEvent = sEvent;
    sEvent = sEvent.toLowerCase();
    var oEvent = oManager.splitGroup(sEvent);
    sEvent = oEvent.event;
    var sGroup = oEvent.group;
    var ele = this._element;
    var nv_id = ele.__nv__id;
    var oDoc = ele.ownerDocument || ele.document || document;
    
    if(nv._p_.hasCustomEvent(sEvent)){
        vFilter = vFilter||"_NONE_";
        var fpCallbackBind = nv.$Fn(fpCallback,this).bind();
        nv._p_.normalCustomEventAttach(ele,sEvent,nv_id,vFilter,fpCallback,fpCallbackBind);
        if(nv._p_.getCustomEvent(sEvent)){
            nv._p_.customEventAttach(sType, sEvent,vFilter,fpCallback,fpCallbackBind,ele,nv.$Fn(this._add,this).bind());
        }
    }else{
        if(sEvent == "domready" && nv.$Jindo.isWindow(ele)){
            nv.$Element(oDoc).attach(sEvent, fpCallback);
            return this;
        }
        
        if(sEvent == "load" && ele === oDoc){
            nv.$Element(window).attach(sEvent, fpCallback);
            return this;
        }
        
        if((!document.addEventListener)&&("domready"==sEvent)){
            if(window.top != window) throw  nv.$Error(nv.$Except.NOT_WORK_DOMREADY,"$Element#attach");
            nv.$Element._domready(ele, fpCallback);
            return this;
        }
        
        sEvent = oManager.revisionEvent(sType, sEvent,realEvent);
        fpCallback = oManager.revisionCallback(sType, sEvent, realEvent, fpCallback);
        
        if(!oManager.isInit(this._key)){
            oManager.init(this._key, ele);
        }
        
        if(!oManager.hasEvent(this._key, sEvent,realEvent)){
            oManager.initEvent(this, sEvent,realEvent,sGroup);
        }
        
        if(!oManager.hasGroup(this._key, sEvent, sGroup)){
            oManager.initGroup(this._key, sEvent, sGroup);
        }
        
        oManager.addEventListener(this._key, sEvent, sGroup, sType, vFilter, fpCallback);
    }
    

    return this;
};

nv._p_.customEventDetach = function(sType,sEvent,vFilter,fpCallback,eEle,fpDel) {
    var customObj = nv._p_.getCustomEventListener(eEle.__nv__id, sEvent, vFilter);
    var customInstance = customObj.custom;
    var events = customInstance.events;

    for(var i = 0, l = events.length; i < l; i++) {
        fpDel(sType, events[i], vFilter, customInstance["_fp"+events[i]]);
    }
};

/**
	�̺�Ʈ�� ������ �� ����ϴ� ���� �Լ�.
	
	@method _del
	@ignore
	@param {String} sType �̺�Ʈ delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
	@param {String} sEvent �̺�Ʈ��.
	@param {String|Function} vFilter ���� �Լ�.
	@param {Function} fpCallback �̺�Ʈ �ݹ��Լ�.
	@return {this} �ν��Ͻ� �ڽ�
 */
nv.$Element.prototype._del = function(sType, sEvent, vFilter, fpCallback){
    var oManager = nv.$Element.eventManager;
    var realEvent = sEvent;
    sEvent = sEvent.toLowerCase();
    var oEvent = oManager.splitGroup(sEvent);
    sEvent = oEvent.event;
    var sGroup = oEvent.group;
    var oDoc = this._element.ownerDocument || this._element.document || document;
    if(nv._p_.hasCustomEvent(sEvent)){
        var nv_id = this._element.__nv__id;
        vFilter = vFilter||"_NONE_";
        
        var oNormal = nv._p_.getNormalEventListener(nv_id, sEvent, vFilter);
        
        
        
        var aWrap = oNormal.wrap_listener;
        var aReal = oNormal.real_listener;
        var aNewWrap = [];
        var aNewReal = [];
        
        for(var i = 0, l = aReal.length; i < l; i++){
            if(aReal[i]!=fpCallback){
                aNewWrap.push(aWrap[i]);
                aNewReal.push(aReal[i]);
            }
        }
        
        if(aNewReal.length==0){
            var oNormalJindo = nv._p_.normalCustomEvent[sEvent][nv_id];
            var count = 0;
            for(var i in oNormalJindo){
                if(i!=="ele"){
                    count++;
                    break;
                }
            }
            if(count === 0){
                delete nv._p_.normalCustomEvent[sEvent][nv_id];
            }else{
                delete nv._p_.normalCustomEvent[sEvent][nv_id][vFilter];
            }
        }
        
        if(nv._p_.customEvent[sEvent]){
            // var customInstance = nv._p_.getCustomEventListener(nv__id, sEvent, vFilter).custom;
//             
            // var aWrap = customInstance.wrap_listener;
            // var aReal = customInstance.real_listener;
            // var aNewWrap = [];
            // var aNewReal = [];
//             
            // for(var i = 0, l = aReal.length; i < l; i++){
                // if(aReal[i]!=fpCallback){
                    // aNewWrap.push(aWrap[i]);
                    // aNewReal.push(aReal[i]);
                // }
            // }
            nv._p_.setCustomEventListener(nv_id, sEvent, vFilter, aNewReal, aNewWrap);
            if(aNewReal.length==0){
                nv._p_.customEventDetach(sType, sEvent,vFilter,fpCallback,this._element,nv.$Fn(this._del,this).bind());
                delete nv._p_.customEventStore[nv_id][sEvent][vFilter];
            }
        }
        
    }else{
        if(sEvent == "domready" && nv.$Jindo.isWindow(this._element)){
            nv.$Element(oDoc).detach(sEvent, fpCallback);
            return this;
        }
        
        if(sEvent == "load" && this._element === oDoc){
            nv.$Element(window).detach(sEvent, fpCallback);
            return this;
        }
        
        sEvent = oManager.revisionEvent(sType, sEvent,realEvent);
        
        if((!document.addEventListener)&&("domready"==sEvent)){
            var aNewDomReady = [];
            var list = nv.$Element._domready.list;
            for(var i=0,l=list.length; i < l ;i++){
                if(list[i]!=fpCallback){
                    aNewDomReady.push(list[i]);
                }   
            }
            nv.$Element._domready.list = aNewDomReady;
            return this;
        }
        // if(sGroup === nv._p_.NONE_GROUP && !nv.$Jindo.isFunction(fpCallback)){
        if(sGroup === nv._p_.NONE_GROUP && !nv.$Jindo.isFunction(fpCallback)&&!vFilter){
            throw new nv.$Error(nv.$Except.HAS_FUNCTION_FOR_GROUP,"$Element#"+(sType=="normal"?"detach":"delegate"));
        }
    
        oManager.removeEventListener(this._key, sEvent, sGroup, sType, vFilter, fpCallback);
    }
    
    return this;
};

/**
	$Element�� �̺�Ʈ�� �����ϴ� ��ü.
	
	@ignore
 */
nv._p_.mouseTouchPointerEvent = function (sEvent){
    var eventMap = {};

    if(window.navigator.msPointerEnabled && window.navigator.msMaxTouchPoints > 0) {
        eventMap = {
            "mousedown":"MSPointerDown",
            "mouseup":"MSPointerUp",
            "mousemove":"MSPointerMove",
            "mouseover":"MSPointerOver",
            "mouseout":"MSPointerOut",
            "touchstart":"MSPointerDown",
            "touchend":"MSPointerUp",
            "touchmove":"MSPointerMove",
            "pointerdown":"MSPointerDown",
            "pointerup":"MSPointerUp",
            "pointermove":"MSPointerMove",
            "pointerover":"MSPointerOver",
            "pointerout":"MSPointerOut",
            "pointercancel":"MSPointerCancel"
        };
    } else if(nv._p_._JINDO_IS_MO) {
        eventMap = {
            "mousedown":"touchstart",
            "mouseup":"touchend",
            "mousemove":"touchmove",
            "pointerdown":"touchstart",
            "pointerup":"touchend",
            "pointermove":"touchmove"
        };
    }

    nv._p_.mouseTouchPointerEvent = function(sEvent) {
        return eventMap[sEvent]?eventMap[sEvent]:sEvent;    
    };
    
    return nv._p_.mouseTouchPointerEvent(sEvent);
};

nv.$Element.eventManager = (function() {
    var eventStore = {};

    function bind(fpFunc, oScope, aPram) {
        return function() {
            var args = nv._p_._toArray( arguments, 0);
            if (aPram.length) args = aPram.concat(args);
            return fpFunc.apply(oScope, args);
        };
    }

    return {
        /**
        	mouseenter�� mouseleave �̺�Ʈ�� ���� ���������� �̺�Ʈ�� �Ҵ� �� �� �����ϰԲ� �ݹ��Լ��� �����ϴ� �Լ�.<br>
	IE���� delegate�� mouseenter�� mouseleave�� ����� ���� ���. 
	
	@method revisionCallback
	@ignore
	@param {String} sType �̺�Ʈ delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
	@param {String} sEvent �̺�Ʈ��
	@param {Function} fpCallback �̺�Ʈ �ݹ��Լ�
         */
        revisionCallback : function(sType, sEvent, realEvent, fpCallback){
            if((document.addEventListener||nv._p_._JINDO_IS_IE&&(sType=="delegate"))&&(realEvent=="mouseenter"||realEvent=="mouseleave")) 
            // ||(nv._p_._JINDO_IS_IE&&(sType=="delegate")&&(realEvent=="mouseenter"||realEvent=="mouseleave")))
               {
                var fpWrapCallback = nv.$Element.eventManager._fireWhenElementBoundary(sType, fpCallback);
                fpWrapCallback._origin_ = fpCallback;
                fpCallback = fpWrapCallback;
            }
            return fpCallback;
        },
        /**
        	mouseenter�� mouseleave �̺�Ʈ�� ���� ���������� ���ķ��̼����ִ� �Լ�.
	
	@method _fireWhenElementBoundary
	@ignore
	@param {String} sType �̺�Ʈ delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
	@param {Function} fpCallback �̺�Ʈ �ݹ��Լ�
         */
        _fireWhenElementBoundary : function(sType, fpCallback){
            return function(oEvent) {
                var woRelatedElement = oEvent.relatedElement?nv.$Element(oEvent.relatedElement):null;
                var eElement = oEvent.currentElement;
                if(sType == "delegate"){
                    eElement = oEvent.element;
                }
                if(woRelatedElement && (woRelatedElement.isEqual(eElement) || woRelatedElement.isChildOf(eElement))) return;
                
                fpCallback(oEvent);
            };
        },
        /**
        	���������� �����ִ� �̺�Ʈ ���� �����ϴ� �Լ�.
	
	@method revisionEvent
	@ignore
	@param {String} sType �̺�Ʈ delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
	@param {String} sEvent �̺�Ʈ��
         */
        revisionEvent : function(sType, sEvent, realEvent){
            if (document.addEventListener !== undefined) {
                this.revisionEvent = function(sType, sEvent, realEvent){

                    // In IE distinguish upper and lower case and if prefix is 'ms' return as well.
                    if(/^ms/i.test(realEvent)){
                        return realEvent;
                    }
                    var customEvent = nv.$Event.hook(sEvent);

                    if(customEvent){
                        if(nv.$Jindo.isFunction(customEvent)){
                            return customEvent(); 
                        }else{
                            return customEvent;
                        }
                    }

                    sEvent = sEvent.toLowerCase();

                    if (sEvent == "domready" || sEvent == "domcontentloaded") {
                        sEvent = "DOMContentLoaded";
                    }else if (sEvent == "mousewheel" && !nv._p_._JINDO_IS_WK && !nv._p_._JINDO_IS_OP && !nv._p_._JINDO_IS_IE) {
                        /*
                          * IE9�� ��쵵 DOMMouseScroll�� �������� ����.
                         */
                        sEvent = "DOMMouseScroll";  
                    }else if (sEvent == "mouseenter" && (!nv._p_._JINDO_IS_IE||sType=="delegate")){
                        sEvent = "mouseover";
                    }else if (sEvent == "mouseleave" && (!nv._p_._JINDO_IS_IE||sType=="delegate")){
                        sEvent = "mouseout";
                    }else if(sEvent == "transitionend"||sEvent == "transitionstart"){
                        var sPostfix = sEvent.replace("transition","");
                        var info = nv._p_.getStyleIncludeVendorPrefix();

                        if(info.transition != "transition"){
                            sPostfix = sPostfix.substr(0,1).toUpperCase() + sPostfix.substr(1);
                        }

                        sEvent = info.transition + sPostfix;
                    }else if(sEvent == "animationstart"||sEvent == "animationend"||sEvent == "animationiteration"){
                        var sPostfix = sEvent.replace("animation","");
                        var info = nv._p_.getStyleIncludeVendorPrefix();

                        if(info.animation != "animation"){
                            sPostfix = sPostfix.substr(0,1).toUpperCase() + sPostfix.substr(1);
                        }

                        sEvent = info.animation + sPostfix;
                    }else if(sEvent === "focusin"||sEvent === "focusout"){
                        sEvent = sEvent === "focusin" ? "focus":"blur";

                    /*
                     * IE���� 9�� ���� ���������� oninput �̺�Ʈ�� ���� fallback�� �ʿ�. IE9�� ���, oninput �̺�Ʈ �����ϳ� input ��ҿ� ������ backspace Ű ������ ������ �ٷ� �ݿ����� �ʴ� ���װ� ����.
    ���� oninput �̺�Ʈ�� ������ ���� ���ε� �ǵ��� �����. - IE9: keyup, IE9 ���� ����: propertychange
                     */
                    } else if(sEvent == "input" && nv._p_._JINDO_IS_IE && document.documentMode <= 9) {
                        sEvent = "keyup";
                    }
                    return nv._p_.mouseTouchPointerEvent(sEvent);
                };
            }else{
                this.revisionEvent = function(sType, sEvent,realEvent){
                    // In IE distinguish upper and lower case and if prefix is 'ms' return as well.
                    if(/^ms/i.test(realEvent)){
                        return realEvent;
                    }
                    var customEvent = nv.$Event.hook(sEvent);
                    if(customEvent){
                        if(nv.$Jindo.isFunction(customEvent)){
                            return customEvent(); 
                        }else{
                            return customEvent;
                        }
                    }
                    /*
                     * IE���� delegate�� mouseenter�� mouseleave�� ����� ���� mouseover�� mouseleave�� �̿��Ͽ� ���ķ��̼� �ϵ��� �����ؾ� ��.
                     */
                    if(sType=="delegate"&&sEvent == "mouseenter") {
                        sEvent = "mouseover";
                    }else if(sType=="delegate"&&sEvent == "mouseleave") {
                        sEvent = "mouseout";
                    } else if(sEvent == "input") {
                        sEvent = "propertychange";
                    }

                    return nv._p_.mouseTouchPointerEvent(sEvent);
                };
            }
            return this.revisionEvent(sType, sEvent,realEvent);
        },
        /**
        			�׽�Ʈ�� ���� �Լ�.
			
			@method test
			@ignore
         */
        test : function(){
            return eventStore;
        },
        /**
        			Ű�� �ش��ϴ� �Լ��� �ʱ�ȭ �Ǿ����� Ȯ���ϴ� �Լ�.
			
			@method isInit
			@ignore
			@param {String} sKey ������Ʈ Ű��
         */
        isInit : function(sKey){
            return !!eventStore[sKey];
        },
        /**
        			�ʱ�ȭ �ϴ� �Լ�.
			
			@method init
			@ignore
			@param {String} sKey ������Ʈ Ű��
			@param {Element} eEle ������Ʈ
         */
        init : function(sKey, eEle){
            eventStore[sKey] = {
                "ele" : eEle,
                "event" : {}
            };
        },
        /**
        			Ű���� �ش��ϴ� ������ ��ȯ.
			
			@method getEventConfig
			@ignore
			@param {String} sKey ������Ʈ Ű��
         */
        getEventConfig : function(sKey){
            return eventStore[sKey];
        },
        /**
        			�ش� Ű�� �̺�Ʈ�� �ִ��� Ȯ���ϴ� �Լ�.
			
			@method  hasEvent
			@ignore
			@param {String} sKey ������Ʈ Ű��
			@param {String} sEvent �̺�Ʈ��
         */
        hasEvent : function(sKey, sEvent,realEvent){
            if(!document.addEventListener && sEvent.toLowerCase() == "domready"){
                if(nv.$Element._domready.list){
                    return nv.$Element._domready.list.length > 0 ? true : false;
                }else{
                    return false;
                }
            }
            
            // sEvent = nv.$Element.eventManager.revisionEvent("", sEvent,realEvent);
            
            try{
                return !!eventStore[sKey]["event"][sEvent];
            }catch(e){
                return false;
            }
        },
        /**
        			�ش� �׷��� �ִ��� Ȯ���ϴ� �Լ�.
			
			@method hasGroup
			@ignore
			@param {String} sKey ������Ʈ Ű�� 
			@param {String} sEvent �̺�Ʈ ��
			@param {String} sEvent �׷��
         */
        hasGroup : function(sKey, sEvent, sGroup){
            return !!eventStore[sKey]["event"][sEvent]["type"][sGroup];
        },
        createEvent : function(wEvent,realEvent,element,delegatedElement){
            // wEvent = wEvent || window.event;
            if (wEvent.currentTarget === undefined) {
                wEvent.currentTarget = element;
            }
            var weEvent = nv.$Event(wEvent);
            if(!weEvent.currentElement){
                weEvent.currentElement = element;
            }
            weEvent.realType = realEvent;
            weEvent.delegatedElement = delegatedElement;
            return weEvent;
        },
        /**
        			�̺�Ʈ�� �ʱ�ȭ �ϴ� �Լ�
			
			@method initEvent
			@ignore
			@param {Hash+} oThis this ��ü
			@param {String} sEvent �̺�Ʈ ��
			@param {String} sEvent �׷��
         */
        initEvent : function(oThis, sEvent, realEvent, sGroup){
            var sKey = oThis._key;
            var oEvent = eventStore[sKey]["event"];
            var that = this;
            
            var fAroundFunc = bind(function(sEvent,realEvent,scope,wEvent){
                wEvent = wEvent || window.event;
                var oEle = wEvent.target || wEvent.srcElement;
                var oManager = nv.$Element.eventManager;
                var oConfig = oManager.getEventConfig((wEvent.currentTarget||this._element).__nv__id);
                
                var oType = oConfig["event"][sEvent].type;
                for(var i in oType){
                    if(oType.hasOwnProperty(i)){
                        var aNormal = oType[i].normal;
                        for(var j = 0, l = aNormal.length; j < l; j++){
                            aNormal[j].call(this,scope.createEvent(wEvent,realEvent,this._element,null));
                        }
                        var oDelegate = oType[i].delegate;
                        var aResultFilter;
                        var afpFilterCallback;
                        for(var k in oDelegate){
                            if(oDelegate.hasOwnProperty(k)){
                                aResultFilter = oDelegate[k].checker(oEle);
                                if(aResultFilter[0]){
                                    afpFilterCallback = oDelegate[k].callback;
                                    var weEvent;//.element = aResultFilter[1];
                                    for(var m = 0, leng = afpFilterCallback.length; m < leng ; m++){
                                        weEvent = scope.createEvent(wEvent,realEvent,this._element,aResultFilter[1]);
                                        weEvent.element = aResultFilter[1];
                                        afpFilterCallback[m].call(this, weEvent);
                                    }
                                }
                            }
                        }
                    }
                    
                }
            },oThis,[sEvent,realEvent,this]);
            
            oEvent[sEvent] = {
                "listener" : fAroundFunc,
                "type" :{}
            }   ;
            
            nv.$Element._eventBind(oThis._element,sEvent,fAroundFunc,(realEvent==="focusin" || realEvent==="focusout"));
            
        },
        /**
        			�׷��� �ʱ�ȭ �ϴ� �Լ�
			
			@method initGroup
			@ignore
			@param {String} sKey ������Ʈ Ű��
			@param {String} sEvent �̺�Ʈ ��
			@param {String} sEvent �׷��
         */
        initGroup : function(sKey, sEvent, sGroup){
            var oType = eventStore[sKey]["event"][sEvent]["type"];
            oType[sGroup] = {
                "normal" : [],
                "delegate" :{}
            };
        },
        /**
        			�̺�Ʈ�� �߰��ϴ� �Լ�
			
			@method addEventListener
			@ignore
			@param {String} ssKey ������Ʈ Ű ��
			@param {String} sEvent �̺�Ʈ��
			@param {String} sGroup �׷��
			@param {String} sType delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
			@param {Function} vFilter ���͸��ϴ� css������ Ȥ�� �����Լ�
			@param {Function} fpCallback �ݹ��Լ�
         */
        addEventListener : function(sKey, sEvent, sGroup, sType, vFilter, fpCallback){
            
            var oEventInfo = eventStore[sKey]["event"][sEvent]["type"][sGroup];
            
            if(sType === "normal"){
                oEventInfo.normal.push(fpCallback);
            }else if(sType === "delegate"){
                if(!this.hasDelegate(oEventInfo,vFilter)){
                    this.initDelegate(eventStore[sKey].ele,oEventInfo,vFilter);
                }
                this.addDelegate(oEventInfo,vFilter,fpCallback);
            }
            
        },
        /**
         			delegate�� �ִ��� Ȯ���ϴ� �Լ�.
			
			@method hasDelegate
			@ignore
			@param {Hash+} oEventInfo �̺�Ʈ ������ü
			@param {Function} vFilter ���͸��ϴ� css������ Ȥ�� �����Լ�
         */
        hasDelegate : function(oEventInfo,vFilter){
            return !!oEventInfo.delegate[vFilter];
        },
        containsElement : function(eOwnEle, eTarget, sCssquery,bContainOwn){
            if(eOwnEle == eTarget&&bContainOwn){
                return nv.$$.test(eTarget,sCssquery);
            }
            var aSelectElement = nv.$$(sCssquery,eOwnEle);
            for(var i = 0, l = aSelectElement.length; i < l; i++){
                if(aSelectElement[i] == eTarget){
                    return true;
                }
            }  
            return false;
        },
        /**
        			delegate�� �ʱ�ȭ �ϴ� �Լ�.
			
			@method initDelegate
			@ignore
			@param {Hash+} eOwnEle
			@param {Hash+} oEventInfo �̺�Ʈ ������ü
			@param {Function} vFilter ���͸��ϴ� css������ Ȥ�� �����Լ�
         */
        initDelegate : function(eOwnEle,oEventInfo,vFilter){
            var fpCheck;
            if(nv.$Jindo.isString(vFilter)){
                fpCheck = bind(function(eOwnEle,sCssquery,oEle){
                    var eIncludeEle = oEle;
                    var isIncludeEle = this.containsElement(eOwnEle, oEle, sCssquery,true);
                    if(!isIncludeEle){
                        var aPropagationElements = this._getParent(eOwnEle,oEle);
                        for(var i = 0, leng = aPropagationElements.length ; i < leng ; i++){
                            eIncludeEle = aPropagationElements[i];
                            if(this.containsElement(eOwnEle, eIncludeEle, sCssquery)){
                                isIncludeEle = true;
                                break;
                            }
                        }
                    }
                    return [isIncludeEle,eIncludeEle];
                },this,[eOwnEle,vFilter]);
            }else{
                fpCheck = bind(function(eOwnEle,fpFilter,oEle){
                    var eIncludeEle = oEle;
                    var isIncludeEle = fpFilter(eOwnEle,oEle);
                    if(!isIncludeEle){
                        var aPropagationElements = this._getParent(eOwnEle,oEle);
                        for(var i = 0, leng = aPropagationElements.length ; i < leng ; i++){
                            eIncludeEle = aPropagationElements[i];
                            if(fpFilter(eOwnEle,eIncludeEle)){
                                isIncludeEle = true;
                                break;
                            }
                        }
                    }
                    return [isIncludeEle,eIncludeEle];
                },this,[eOwnEle,vFilter]);
            }
            oEventInfo.delegate[vFilter] = {
                "checker" : fpCheck,
                "callback" : []
            };
        },
        /**
        			delegate�� �߰��ϴ� �Լ�.
			
			@method addDelegate
			@ignore
			@param {Hash+} oEventInfo �̺�Ʈ ������ü
			@param {Function} vFilter ���͸��ϴ� css������ Ȥ�� �����Լ�
			@param {Function} fpCallback �ݹ��Լ�
         */
        addDelegate : function(oEventInfo,vFilter,fpCallback){
            oEventInfo.delegate[vFilter].callback.push(fpCallback);
        },
        /**
        			�̺�Ʈ�� �����ϴ� �Լ�.
			
			@method removeEventListener
			@ignore
			@param {String} ssKey ������Ʈ Ű ��
			@param {String} sEvent �̺�Ʈ��
			@param {String} sGroup �׷��
			@param {String} sType delegate���� �Ϲ� �̺�Ʈ���� Ȯ��.
			@param {Function} vFilter ���͸��ϴ� css������ Ȥ�� �����Լ�
			@param {Function} fpCallback �ݹ��Լ�
         */
        removeEventListener : function(sKey, sEvent, sGroup, sType, vFilter, fpCallback){
            var oEventInfo;
            try{
                oEventInfo = eventStore[sKey]["event"][sEvent]["type"][sGroup];
            }catch(e){
                return;
            }
            var aNewCallback = [];
            var aOldCallback;
            if(sType === "normal"){
                aOldCallback = oEventInfo.normal;
            }else{
                // console.log(oEventInfo.delegate,oEventInfo.delegate[vFilter],vFilter);
                aOldCallback  = oEventInfo.delegate[vFilter].callback;
            }
            if (sEvent == nv._p_.NONE_GROUP || nv.$Jindo.isFunction(fpCallback)) {
                for(var i = 0, l = aOldCallback.length; i < l; i++){
                    if((aOldCallback[i]._origin_||aOldCallback[i]) != fpCallback){
                        aNewCallback.push(aOldCallback[i]);
                    }
                }
            }
            if(sType === "normal"){
                
                delete oEventInfo.normal;
                oEventInfo.normal = aNewCallback;
            }else if(sType === "delegate"){
                delete oEventInfo.delegate[vFilter].callback;
                oEventInfo.delegate[vFilter].callback = aNewCallback;
            }
            
            this.cleanUp(sKey, sEvent);
        },
        /**
        			��� �̺�Ʈ�� �����ϴ� �Լ�(���� ���Ұ�.)
			
			@method cleanUpAll
			@ignore
         */
        cleanUpAll : function(){
            var oEvent;
            for(var sKey in eventStore){
                if (eventStore.hasOwnProperty(sKey)) {
                    this.cleanUpUsingKey(sKey, true);
                }
            }
        },
        /**
        			������Ʈ Ű�� �̿��Ͽ� ��� �̺�Ʈ�� ������ �� ���.
			
			@method cleanUpUsingKey
			@ignore
			@param {String} sKey
         */
        cleanUpUsingKey : function(sKey, bForce){
            var oEvent;
            
            if(!eventStore[sKey] || !eventStore[sKey].event){
            	return;
            }
            
            oEvent = eventStore[sKey].event;
            
            for(var sEvent in oEvent){
                if (oEvent.hasOwnProperty(sEvent)) {
                    this.cleanUp(sKey, sEvent, bForce);
                }
            }
        },
        /**
        			Ű�� �ش��ϴ� ��� �̺�Ʈ�� �����ϴ� �Լ�(���� ���Ұ�)
			
			@method cleanUp
			@ignore
			@param {String} ssKey ������Ʈ Ű ��
			@param {String} sEvent �̺�Ʈ��
			@param {Boolean} bForce ������ ������ ������ ����
         */
        cleanUp : function(sKey, sEvent, bForce){
            var oTypeInfo; 
            try{
                oTypeInfo = eventStore[sKey]["event"][sEvent]["type"];
            }catch(e){
                return;
                
            }
            var oEventInfo;
            var bHasEvent = false;
            if(!bForce){
                for(var i in oTypeInfo){
                    if (oTypeInfo.hasOwnProperty(i)) {
                        oEventInfo = oTypeInfo[i];
                        if(oEventInfo.normal.length){
                            bHasEvent = true;
                            break;
                        }
                        var oDele = oEventInfo.delegate;
                        for(var j in oDele){ 
                            if (oDele.hasOwnProperty(j)) {
                                if(oDele[j].callback.length){
                                    bHasEvent = true;
                                    break;
                                }
                            }
                        }
                        if(bHasEvent) break;
                        
                    }
                }
            }
            if(!bHasEvent){
                nv.$Element._unEventBind(eventStore[sKey].ele, sEvent, eventStore[sKey]["event"][sEvent]["listener"]);
                delete eventStore[sKey]["event"][sEvent];
                var bAllDetach = true;
                var oEvent = eventStore[sKey]["event"];
                for(var k in oEvent){
                    if (oEvent.hasOwnProperty(k)) {
                        bAllDetach = false;
                        break;
                    }
                }
                if(bAllDetach){
                    delete eventStore[sKey];
                }
            }
        },
        /**
        			�̺�Ʈ ��� �׷��� �����ϴ� �Լ�.
			
			@method splitGroup
			@ignore
			@param {String} sEvent �̺�Ʈ��
         */
        splitGroup : function(sEvent){
            var aMatch = /\s*(.+?)\s*\(\s*(.*?)\s*\)/.exec(sEvent);
            if(aMatch){
                return {
                    "event" : aMatch[1].toLowerCase(),
                    "group" : aMatch[2].toLowerCase()
                };
            }else{
                return {
                    "event" : sEvent.toLowerCase(),
                    "group" : nv._p_.NONE_GROUP
                };
            }
        },
        /**
        			delegate���� �θ� ã�� �Լ�.
			
			@method _getParent
			@ignore
			@param {Element} oOwnEle �ڽ��� ������Ʈ
			@param {Element} oEle �� ������Ʈ
         */
        _getParent : function(oOwnEle, oEle){
            var e = oOwnEle;
            var a = [], p = null;
            var oDoc = oEle.ownerDocument || oEle.document || document;
            while (oEle.parentNode && p != e) {
                p = oEle.parentNode;
                if (p == oDoc.documentElement) break;
                a[a.length] = p;
                oEle = p;
            }
        
            return a;
        }
    };
})();
/*
// $Element�� ���� ����.
//
// {
//	"key" : {
//		"ele" : ele,
//		"event" : {
//			"click":{
//				"listener" : function(){},
//				"type":{
//					"-none-" : {
//						"normal" : [],
//						"delegate" :{
//							"vFilter" :{
//								"checker" : function(){},
//								"callback" : [function(){}]
//							}
//							
//						}
//					}
//				}
//			}
//		}
//	}
//}
 */
//-!nv.$Element.event_etc.hidden end!-//

//-!nv.$Element.domready.hidden start!-//
/**
	Emulates the domready (=DOMContentLoaded) event in Internet Explorer.
	
	@method _domready
	@filter desktop
	@ignore
*/
nv.$Element._domready = function(doc, func) {
    if (nv.$Element._domready.list === undefined) {
        var f = null;
        
        nv.$Element._domready.list = [func];
        
        // use the trick by Diego Perini
        // http://javascript.nwbox.com/IEContentLoaded/
        var done = false, execFuncs = function(){
            if(!done) {
                done = true;
                var l = nv.$Element._domready.list.concat();
                var evt = {
                    type : "domready",
                    target : doc,
                    currentTarget : doc
                };

                while(f = l.shift()) f(evt);
            }
        };
        
        (function (){
            try {
                doc.documentElement.doScroll("left");
            } catch(e) {
                setTimeout(arguments.callee, 50);
                return;
            }
            execFuncs();
        })();

        // trying to always fire before onload
        doc.onreadystatechange = function() {
            if (doc.readyState == 'complete') {
                doc.onreadystatechange = null;
                execFuncs();
            }
        };

    } else {
        nv.$Element._domready.list.push(func);
    }
};

//-!nv.$Element.domready.hidden end!-//



/**
 	@fileOverview $Element�� Ȯ�� �޼��带 ������ ����
	@name element.extend.js
	@author NAVER Ajax Platform
 */

//-!nv.$Element.prototype.appear start(nv.$Element.prototype.opacity,nv.$Element.prototype.show)!-//
/**
 	appear() �޼���� HTML ��Ҹ� ������ ��Ÿ���� �Ѵ�(Fade-in ȿ��)
	
	@method appear
	@param {Numeric} [nDuration] HTML ��Ұ� ������ ��Ÿ�� ������ �ɸ��� �ð�. ������ ��(second)�̴�.
	@param {Function} [fCallback] HTML ��Ұ� ������ ��Ÿ�� �Ŀ� ������ �ݹ� �Լ�.
	@return {this} Fade-in ȿ���� ������ �ν��Ͻ� �ڽ�
	@remark
		<ul class="disc">
			<li>���ͳ� �ͽ��÷η� 6 �������� filter�� ����ϸ鼭 �ش� ��Ұ� position �Ӽ��� ������ ������ ������� ������ �ִ�. �� ��쿡�� HTML ��ҿ� position �Ӽ��� ����� ���������� ����� �� �ִ�.</li>
			<li>Webkit ����� ������(Safari 5 ���� �̻�, Mobile Safari, Chrome, Mobile Webkit), Opear 10.60 ���� �̻��� ������������ CSS3 transition �Ӽ��� ����Ѵ�. �� �̿��� ������������ �ڹٽ�ũ��Ʈ�� ����Ѵ�.</li>
		</ul>
	@see http://www.w3.org/TR/css3-transitions/ CSS Transitions - W3C
	@see nv.$Element#show
	@see nv.$Element#disappear
	@example
		$Element("sample1").appear(5, function(){
			$Element("sample2").appear(3);
		});
		
		//Before
		<div style="display: none; background-color: rgb(51, 51, 153); width: 100px; height: 50px;" id="sample1">
			<div style="display: none; background-color: rgb(165, 10, 81); width: 50px; height: 20px;" id="sample2">
			</div>
		</div>
		
		//After(1) : sample1 ��Ұ� ��Ÿ��
		<div style="display: block; background-color: rgb(51, 51, 153); width: 100px; height: 50px; opacity: 1;" id="sample1">
			<div style="display: none; background-color: rgb(165, 10, 81); width: 50px; height: 20px;" id="sample2">
			</div>
		</div>
		
		//After(2) : sample2 ��Ұ� ��Ÿ��
		<div style="display: block; background-color: rgb(51, 51, 153); width: 100px; height: 50px; opacity: 1;" id="sample1">
			<div style="display: block; background-color: rgb(165, 10, 81); width: 50px; height: 20px; opacity: 1;" id="sample2">
			</div>
		</div>
 */
nv.$Element.prototype.appear = function(duration, callback) {
    //-@@$Element.appear-@@//
    var oTransition = nv._p_.getStyleIncludeVendorPrefix();
    var name = oTransition.transition;
    var endName = name == "transition" ? "end" : "End";

    function appear() {
        var oArgs = g_checkVarType(arguments, {
            '4voi' : [ ],
            '4num' : [ 'nDuration:Numeric'],
            '4fun' : [ 'nDuration:Numeric' ,'fpCallback:Function+']
        },"$Element#appear");
        switch(oArgs+""){
            case "4voi":
                duration = 0.3;
                callback = function(){};
                break;
            case "4num":
                duration = oArgs.nDuration;
                callback = function(){};
                break;
            case "4fun":
                duration = oArgs.nDuration;
                callback = oArgs.fpCallback;
                
        }
        return [duration, callback];
    }

    if(oTransition.transition) {
        nv.$Element.prototype.appear = function(duration, callback) {
            var aOption = appear.apply(this,nv._p_._toArray(arguments));
            duration = aOption[0];
            callback = aOption[1];
            var self = this;
            
            if(this.visible()){
                
                setTimeout(function(){
                    callback.call(self,self);
                },16);
                
                return this; 
            }
            
            
            var ele = this._element;
            var name = oTransition.transition;
            var bindFunc = function(){
                self.show();
                ele.style[name + 'Property'] = '';
                ele.style[name + 'Duration'] = '';
                ele.style[name + 'TimingFunction'] = '';
                ele.style.opacity = '';
                callback.call(self,self);
                ele.removeEventListener(name+endName, arguments.callee , false );
            };
            if(!this.visible()){
                ele.style.opacity = ele.style.opacity||0;
                self.show();
            }
            ele.addEventListener( name+endName, bindFunc , false );
            ele.style[name + 'Property'] = 'opacity';
            ele.style[name + 'Duration'] = duration+'s';
            ele.style[name + 'TimingFunction'] = 'linear';

            nv._p_.setOpacity(ele,"1");
            return this;
        };
    } else {
        nv.$Element.prototype.appear = function(duration, callback) {
            var aOption = appear.apply(this,nv._p_._toArray(arguments));
            duration = aOption[0];
            callback = aOption[1];
            var self = this;
            var op   = this.opacity();
            if(this._getCss(this._element,"display")=="none") op = 0;
            
            if (op == 1) return this;
            try { clearTimeout(this._fade_timer); } catch(e){}

            var step = (1-op) / ((duration||0.3)*100);
            var func = function(){
                op += step;
                self.opacity(op);

                if (op >= 1) {
                    self._element.style.filter="";
                    callback.call(self,self);
                } else {
                    self._fade_timer = setTimeout(func, 10);
                }
            };

            this.show();
            func();
            return this;
        };
    }
    return this.appear.apply(this,arguments);
    
};
//-!nv.$Element.prototype.appear end!-//

//-!nv.$Element.prototype.disappear start(nv.$Element.prototype.opacity)!-//
/**
 	disappear() �޼���� HTML ��Ҹ� ������ ������� �Ѵ�(Fade-out ȿ��).
	
	@method disappear
	@param {Numeric} [nDuration] HTML ��� ������ ����� ������ �ɸ��� �ð�. (���� ��)
	@param {Function} [fCallback] HTML ��Ұ� ������ ����� �Ŀ� ������ �ݹ� �Լ�.
	@return {this} Fade-out ȿ���� ������ �ν��Ͻ� �ڽ�
	@remark
		<ul class="disc">
			<li>HTML ��Ұ� ������ ������� �ش� ����� display �Ӽ��� none���� ���Ѵ�.</li>
			<li>Webkit ����� ������(Safari 5 ���� �̻�, Mobile Safari, Chrome, Mobile Webkit), Opear 10.6 ���� �̻��� ������������ CSS3 transition �Ӽ��� ����Ѵ�. �� �̿��� ������������ �ڹٽ�ũ��Ʈ�� ����Ѵ�.</li>
		</ul>
	@see http://www.w3.org/TR/css3-transitions/ CSS Transitions - W3C
	@see nv.$Element#hide
	@see nv.$Element#appear
	@example
		$Element("sample1").disappear(5, function(){
			$Element("sample2").disappear(3);
		});
		
		//Before
		<div id="sample1" style="background-color: rgb(51, 51, 153); width: 100px; height: 50px;">
		</div>
		<div id="sample2" style="background-color: rgb(165, 10, 81); width: 100px; height: 50px;">
		</div>
		
		//After(1) : sample1 ��Ұ� �����
		<div id="sample1" style="background-color: rgb(51, 51, 153); width: 100px; height: 50px; opacity: 1; display: none;">
		</div>
		<div id="sample2" style="background-color: rgb(165, 10, 81); width: 100px; height: 50px;">
		</div>
		
		//After(2) : sample2 ��Ұ� �����
		<div id="sample1" style="background-color: rgb(51, 51, 153); width: 100px; height: 50px; opacity: 1; display: none;">
		</div>
		<div id="sample2" style="background-color: rgb(165, 10, 81); width: 100px; height: 50px; opacity: 1; display: none;">
		</div>
 */
nv.$Element.prototype.disappear = function(duration, callback) {
    //-@@$Element.disappear-@@//
    var oTransition = nv._p_.getStyleIncludeVendorPrefix();
    var name = oTransition.transition;
    var endName = name == "transition" ? "end" : "End";

    function disappear(){
        var oArgs = g_checkVarType(arguments, {
            '4voi' : [ ],
            '4num' : [ 'nDuration:Numeric'],
            '4fun' : [ 'nDuration:Numeric' ,'fpCallback:Function+']
        },"$Element#disappear");
        switch(oArgs+""){
            case "4voi":
                duration = 0.3;
                callback = function(){};
                break;
            case "4num":
                duration = oArgs.nDuration;
                callback = function(){};
                break;
            case "4fun":
                duration = oArgs.nDuration;
                callback = oArgs.fpCallback;
                
        }
        return [duration, callback];
    }
    if (oTransition.transition) {
        nv.$Element.prototype.disappear = function(duration, callback) {
            var aOption = disappear.apply(this,nv._p_._toArray(arguments));
            duration = aOption[0];
            callback = aOption[1];
            
            var self = this;
            
            if(!this.visible()){
                
                setTimeout(function(){
                    callback.call(self,self);
                },16);
                
                return this; 
            }
            
            // endName = "End";
            // var name = "MozTransition";
            var name = oTransition.transition;
            var ele = this._element;
            var bindFunc = function(){
                self.hide();
                ele.style[name + 'Property'] = '';
                ele.style[name + 'Duration'] = '';
                ele.style[name + 'TimingFunction'] = '';
                ele.style.opacity = '';
                callback.call(self,self);
                ele.removeEventListener(name+endName, arguments.callee , false );
            };

            ele.addEventListener( name+endName, bindFunc , false );
            ele.style[name + 'Property'] = 'opacity';
            ele.style[name + 'Duration'] = duration+'s';
            ele.style[name + 'TimingFunction'] = 'linear';
            
            nv._p_.setOpacity(ele,'0');
            return this;
        };
    }else{
        nv.$Element.prototype.disappear = function(duration, callback) {
            var aOption = disappear.apply(this,nv._p_._toArray(arguments));
            duration = aOption[0];
            callback = aOption[1];
            
            var self = this;
            var op   = this.opacity();
    
            if (op == 0) return this;
            try { clearTimeout(this._fade_timer); } catch(e){}

            var step = op / ((duration||0.3)*100);
            var func = function(){
                op -= step;
                self.opacity(op);

                if (op <= 0) {
                    self._element.style.display = "none";
                    self.opacity(1);
                    callback.call(self,self);
                } else {
                    self._fade_timer = setTimeout(func, 10);
                }
            };

            func();
            return this;
        };
    }
    return this.disappear.apply(this,arguments);
};
//-!nv.$Element.prototype.disappear end!-//

//-!nv.$Element.prototype.offset start!-//
/**
 	offset() �޼���� HTML ����� ��ġ�� �����´�.
	
	@method offset
	@return {Object} HTML ����� ��ġ ���� ��ü�� ��ȯ�Ѵ�.
		@return {Number} .top ������ �� ������ HTML ����� �� �κб����� �Ÿ�
		@return {Number} .left ������ ���� �����ڸ����� HTML ����� ���� �����ڸ������� �Ÿ�
	@remark
		<ul class="disc">
			<li>��ġ�� �����ϴ� �������� �������� �������� ǥ���ϴ� ȭ���� ���� �� �𼭸��̴�.</li>
			<li>HTML ��Ұ� ���̴� ����(display)���� �����ؾ� �Ѵ�. ��Ұ� ȭ�鿡 ������ ������ ���������� �������� ���� �� �ִ�.</li>
			<li>�Ϻ� �������� �Ϻ� ��Ȳ���� inline ��ҿ� ���� ��ġ�� �ùٸ��� ������ ���ϴ� ������ ������, �� ��� �ش� ����� position �Ӽ��� relative ������ �ٲ㼭 �ذ��� �� �ִ�.</li>
		</ul>
	@example
		<style type="text/css">
			div { background-color:#2B81AF; width:20px; height:20px; float:left; left:100px; top:50px; position:absolute;}
		</style>
		
		<div id="sample"></div>
		
		// ��ġ �� ��ȸ
		$Element("sample").offset(); // { left=100, top=50 }
 */
/**
 	offset() �޼���� HTML ����� ��ġ�� �����Ѵ�.
	
	@method offset
	@param {Numeric} nTop ������ �� ������ HTML ����� �� �κб����� �Ÿ�. ������ �ȼ�(px)�̴�.
	@param {Numeric} nLeft ������ ���� �����ڸ����� HTML ����� ���� �����ڸ������� �Ÿ�. ������ �ȼ�(px)�̴�.
	@return {this} ��ġ ���� �ݿ��� �ν��Ͻ� �ڽ�
	@remark
		<ul class="disc">
			<li>��ġ�� �����ϴ� �������� �������� �������� ǥ���ϴ� ȭ���� ���� �� �𼭸��̴�.</li>
			<li>HTML ��Ұ� ���̴� ����(display)���� �����ؾ� �Ѵ�. ��Ұ� ȭ�鿡 ������ ������ ���������� �������� ���� �� �ִ�.</li>
			<li>�Ϻ� �������� �Ϻ� ��Ȳ���� inline ��ҿ� ���� ��ġ�� �ùٸ��� ������ ���ϴ� ������ ������, �� ��� �ش� ����� position �Ӽ��� relative ������ �ٲ㼭 �ذ��� �� �ִ�.</li>
		</ul>
	@example
		<style type="text/css">
			div { background-color:#2B81AF; width:20px; height:20px; float:left; left:100px; top:50px; position:absolute;}
		</style>
		
		<div id="sample"></div>
		
		// ��ġ �� ����
		$Element("sample").offset(40, 30);
		
		//Before
		<div id="sample"></div>
		
		//After
		<div id="sample" style="top: 40px; left: 30px;"></div>
 */
nv.$Element.prototype.offset = function(nTop, nLeft) {
    //-@@$Element.offset-@@//
    var oArgs = g_checkVarType(arguments, {
        'g' : [ ],
        's' : [ 'nTop:Numeric', 'nLeft:Numeric']
    },"$Element#offset");
    
    switch(oArgs+""){
        case "g":
            return this.offset_get();
            
        case "s":
            return this.offset_set(oArgs.nTop, oArgs.nLeft);
            
    }
};

nv.$Element.prototype.offset_set = function(nTop,nLeft) {
    var oEl = this._element;
    var oPhantom = null;
    
    if (isNaN(parseFloat(this._getCss(oEl,'top')))) oEl.style.top = "0px";
    if (isNaN(parseFloat(this._getCss(oEl,'left')))) oEl.style.left = "0px";

    var oPos = this.offset_get();
    var oGap = { top : nTop - oPos.top, left : nLeft - oPos.left };
    oEl.style.top = parseFloat(this._getCss(oEl,'top')) + oGap.top + 'px';
    oEl.style.left = parseFloat(this._getCss(oEl,'left')) + oGap.left + 'px';

    return this;
};

nv.$Element.prototype.offset_get = function(nTop,nLeft) {
    var oEl = this._element,
        oPhantom = null,
        bIE = nv._p_._JINDO_IS_IE,
        nVer = 0;

    if(bIE) {
        nVer = document.documentMode || nv.$Agent().navigator().version;
    }

    var oPos = { left : 0, top : 0 },
        oDoc = oEl.ownerDocument || oEl.document || document,
        oHtml = oDoc.documentElement,
        oBody = oDoc.body;

    if(oEl.getBoundingClientRect) { // has getBoundingClientRect
        if(!oPhantom) {
            var bHasFrameBorder = (window == top);

            if(!bHasFrameBorder) {
                try {
                    bHasFrameBorder = (window.frameElement && window.frameElement.frameBorder == 1);
                } catch(e){}
            }

            if((bIE && nVer < 8 && window.external) && bHasFrameBorder&&document.body.contains(oEl)) {
                oPhantom = { left: 2, top: 2 };
            } else {
                oPhantom = { left: 0, top: 0 };
            }
        }

        var box;

        try {
            box = oEl.getBoundingClientRect();
        } catch(e) {
            box = { left: 0, top: 0};
        }

        if (oEl !== oHtml && oEl !== oBody) {
            oPos.left = box.left - oPhantom.left;
            oPos.top = box.top - oPhantom.top;
            oPos.left += oHtml.scrollLeft || oBody.scrollLeft;
            oPos.top += oHtml.scrollTop || oBody.scrollTop;

        }

    } else if (oDoc.getBoxObjectFor) { // has getBoxObjectFor
        var box = oDoc.getBoxObjectFor(oEl),
            vpBox = oDoc.getBoxObjectFor(oHtml || oBody);

        oPos.left = box.screenX - vpBox.screenX;
        oPos.top = box.screenY - vpBox.screenY;

    } else {
        for(var o = oEl; o; o = o.offsetParent) {
            oPos.left += o.offsetLeft;
            oPos.top += o.offsetTop;
        }

        for(var o = oEl.parentNode; o; o = o.parentNode) {
            if (o.tagName == 'BODY') break;
            if (o.tagName == 'TR') oPos.top += 2;

            oPos.left -= o.scrollLeft;
            oPos.top -= o.scrollTop;
        }
    }

    return oPos;
};
//-!nv.$Element.prototype.offset end!-//

//-!nv.$Element.prototype.evalScripts start!-//
/**
 	evalScripts() �޼���� ���ڿ��� ���Ե� JavaScript �ڵ带 �����Ѵ�.<br>
	&lt;script&gt; �±װ� ���Ե� ���ڿ��� �Ķ���ͷ� �����ϸ�, &lt;script&gt; �ȿ� �ִ� ������ �Ľ��Ͽ� eval() �޼��带 �����Ѵ�.
	
	@method evalScripts
	@param {String+} sHTML &lt;script&gt; ��Ұ� ���Ե� HTML ���ڿ�.
	@return {this} �ν��Ͻ� �ڽ�
	@example
		// script �±װ� ���Ե� ���ڿ��� ����
		var response = "<script type='text/javascript'>$Element('sample').appendHTML('<li>4</li>')</script>";
		
		$Element("sample").evalScripts(response);
		
		//Before
		<ul id="sample">
			<li>1</li>
			<li>2</li>
			<li>3</li>
		</ul>
		
		//After
		<ul id="sample">
			<li>1</li>
			<li>2</li>
			<li>3</li>
		<li>4</li></ul>
 */
nv.$Element.prototype.evalScripts = function(sHTML) {
    //-@@$Element.evalScripts-@@//
    var oArgs = g_checkVarType(arguments, {
        '4str' : [ "sHTML:String+" ]
    },"$Element#evalScripts");
    var aJS = [];
    var leftScript = '<script(\\s[^>]+)*>(.*?)</';
    var rightScript = 'script>';
    sHTML = sHTML.replace(new RegExp(leftScript+rightScript, 'gi'), function(_1, _2, sPart) { aJS.push(sPart); return ''; });
    eval(aJS.join('\n'));
    
    return this;

};
//-!nv.$Element.prototype.evalScripts end!-//

//-!nv.$Element.prototype.clone start!-//
/**
   	cloneNode�� ���� element�� �����ϴ� �޼����̴�.  
  	@method clone
  	@since 2.8.0
	@param {Boolean} [bDeep=true] �ڽĳ����� �������� ����(
	@return {nv.$Element} ������ $Element
	@example

		<div id="sample">
		    <div>Hello</div>
		</div>
		
		//�ڽĳ����� ����
		$Element("sample").clone(); 
		-> 
		$Element(
			<div id="sample">
	    		<div>Hello</div>
			</div>
		);
		
		//���γ�常 ����
		$Element("sample").clone(false); 
		-> 
		$Element(
			<div id="sample">
			</div>
		);
 */
nv.$Element.prototype.clone = function(bDeep) {
    var oArgs = g_checkVarType(arguments, {
        'default' : [ ],
        'set' : [ 'bDeep:Boolean' ]
    },"$Element#clone");
    
    if(oArgs+"" == "default") {
        bDeep = true;
    }
    
    return nv.$Element(this._element.cloneNode(bDeep));
};
//-!nv.$Element.prototype.clone end!-//

//-!nv.$Element._common.hidden start!-//
/**
 * @ignore
 */
nv.$Element._common = function(oElement,sMethod){

    try{
        return nv.$Element(oElement)._element;
    }catch(e){
        throw TypeError(e.message.replace(/\$Element/g,"$Element#"+sMethod).replace(/Element\.html/g,"Element.html#"+sMethod));
    }
};
//-!nv.$Element._common.hidden end!-//
//-!nv.$Element._prepend.hidden start(nv.$)!-//
/**
 	element�� �տ� ���϶� ���Ǵ� �Լ�.
	
	@method _prepend
	@param {Element} elBase ���� ������Ʈ
	@param {Element} elAppend ���� ������Ʈ
	@return {nv.$Element} �ι�° �Ķ������ ������Ʈ
	@ignore
 */
nv.$Element._prepend = function(oParent, oChild){
    var nodes = oParent.childNodes;
    if (nodes.length > 0) {
        oParent.insertBefore(oChild, nodes[0]);
    } else {
        oParent.appendChild(oChild);
    }
};
//-!nv.$Element._prepend.hidden end!-//

//-!nv.$Element.prototype.append start(nv.$Element._common)!-//
/**
 	append() �޼���� nv.$Element() ��ü�� �ִ� ����� ������ �ڽ� ���� �Ķ���ͷ� ������ HTML ��Ҹ� �����Ѵ�.
	
	@method append
	@syntax sId
	@syntax vElement
	@param {String+} sId ������ �ڽ� ���� ������ HTML ����� ID
	@param {Element+ | Node} vElement ������ �ڽ� ���� ������ HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#prepend
	@see nv.$Element#before
	@see nv.$Element#after
	@see nv.$Element#appendTo
	@see nv.$Element#prependTo
	@see nv.$Element#wrap
	@example
		// ID�� sample1�� HTML ��ҿ�
		// ID�� sample2�� HTML ��Ҹ� �߰�
		$Element("sample1").append("sample2");
		
		//Before
		<div id="sample2">
		    <div>Hello 2</div>
		</div>
		<div id="sample1">
		    <div>Hello 1</div>
		</div>
		
		//After
		<div id="sample1">
			<div>Hello 1</div>
			<div id="sample2">
				<div>Hello 2</div>
			</div>
		</div>
	@example
		// ID�� sample�� HTML ��ҿ�
		// ���ο� DIV ��Ҹ� �߰�
		var elChild = $("<div>Hello New</div>");
		$Element("sample").append(elChild);
		
		//Before
		<div id="sample">
			<div>Hello</div>
		</div>
		
		//After
		<div id="sample">
			<div>Hello </div>
			<div>Hello New</div>
		</div>
 */
nv.$Element.prototype.append = function(oElement) {
    //-@@$Element.append-@@//
    this._element.appendChild(nv.$Element._common(oElement,"append"));
    return this;
};
//-!nv.$Element.prototype.append end!-//

//-!nv.$Element.prototype.prepend start(nv.$Element._prepend)!-//
/** 
 	prepend() �޼���� nv.$Element() ��ü�� �ִ� ����� ù ��° �ڽ� ���� �Ķ���ͷ� ������ HTML ��Ҹ� �����Ѵ�.
	
	@method prepend
	@syntax sId
	@syntax vElement
	@param {String+} sId ù ��° �ڽ� ���� ������ HTML ����� ID
	@param {Element+ | Node} vElement ù ��° �ڽ� ���� ������ HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#append
	@see nv.$Element#before
	@see nv.$Element#after
	@see nv.$Element#appendTo
	@see nv.$Element#prependTo
	@see nv.$Element#wrap
	@example
		// ID�� sample1�� HTML ��ҿ���
		// ID�� sample2�� HTML ��Ҹ� ù ��° �ڽ� ���� �̵�
		$Element("sample1").prepend("sample2");
		
		//Before
		<div id="sample1">
		    <div>Hello 1</div>
			<div id="sample2">
			    <div>Hello 2</div>
			</div>
		</div>
		
		//After
		<div id="sample1">
			<div id="sample2">
			    <div>Hello 2</div>
			</div>
		    <div>Hello 1</div>
		</div>
	@example
		// ID�� sample�� HTML ��ҿ�
		// ���ο� DIV ��Ҹ� �߰�
		var elChild = $("<div>Hello New</div>");
		$Element("sample").prepend(elChild);
		
		//Before
		<div id="sample">
			<div>Hello</div>
		</div>
		
		//After
		<div id="sample">
			<div>Hello New</div>
			<div>Hello</div>
		</div>
 */
nv.$Element.prototype.prepend = function(oElement) {
    //-@@$Element.prepend-@@//
    nv.$Element._prepend(this._element, nv.$Element._common(oElement,"prepend"));
    
    return this;
};
//-!nv.$Element.prototype.prepend end!-//

//-!nv.$Element.prototype.replace start(nv.$Element._common)!-//
/**
 	replace() �޼���� nv.$Element() ��ü ������ HTML ��Ҹ� ������ �Ķ������ ��ҷ� ��ü�Ѵ�.
	
	@method replace
	@syntax sId
	@syntax vElement
	@param {String+} sId ��ü�� HTML ����� ID
	@param {Element+ | Node} vElement ��ü�� HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@example
		// ID�� sample1�� HTML ��ҿ���
		// ID�� sample2�� HTML ��ҷ� ��ü
		$Element('sample1').replace('sample2');
		
		//Before
		<div>
			<div id="sample1">Sample1</div>
		</div>
		<div id="sample2">Sample2</div>
		
		//After
		<div>
			<div id="sample2">Sample2</div>
		</div>
	@example
		// ���ο� DIV ��ҷ� ��ü
		$Element("btn").replace($("<div>Sample</div>"));
		
		//Before
		<button id="btn">Sample</button>
		
		//After
		<div>Sample</div>
 */
nv.$Element.prototype.replace = function(oElement) {
    //-@@$Element.replace-@@//
    oElement = nv.$Element._common(oElement,"replace");
    if(nv.cssquery) nv.cssquery.release();
    var e = this._element;
    var oParentNode = e.parentNode;
    if(oParentNode&&oParentNode.replaceChild){
        oParentNode.replaceChild(oElement,e);
        return this;
    }
    
    var _o = oElement;

    oParentNode.insertBefore(_o, e);
    oParentNode.removeChild(e);

    return this;
};
//-!nv.$Element.prototype.replace end!-//

//-!nv.$Element.prototype.appendTo start(nv.$Element._common)!-//
/**
 	appendTo() �޼���� nv.$Element() ��ü�� �ִ� ��Ҹ� �Ķ���ͷ� ������ ����� ������ �ڽ� ��ҷ� �����Ѵ�.
	
	@method appendTo
	@syntax sId
	@syntax vElement
	@param {String+} sId ������ �ڽ� ��尡 ���� �� HTML ����� ID
	@param {Element+ | Node} vElement ������ �ڽ� ��尡 ���� �� HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#append
	@see nv.$Element#prepend
	@see nv.$Element#before
	@see nv.$Element#after
	@see nv.$Element#prependTo
	@see nv.$Element#wrap
	@example
		// ID�� sample2�� HTML ��ҿ�
		// ID�� sample1�� HTML ��Ҹ� �߰�
		$Element("sample1").appendTo("sample2");
		
		//Before
		<div id="sample1">
		    <div>Hello 1</div>
		</div>
		<div id="sample2">
		    <div>Hello 2</div>
		</div>
		
		//After
		<div id="sample2">
		    <div>Hello 2</div>
			<div id="sample1">
			    <div>Hello 1</div>
			</div>
		</div>
 */
nv.$Element.prototype.appendTo = function(oElement) {
    //-@@$Element.appendTo-@@//
    nv.$Element._common(oElement,"appendTo").appendChild(this._element);
    return this;
};
//-!nv.$Element.prototype.appendTo end!-//

//-!nv.$Element.prototype.prependTo start(nv.$Element._prepend, nv.$Element._common)!-//
/**
 	prependTo() �޼���� nv.$Element() ��ü�� �ִ� ��Ҹ� �Ķ���ͷ� ������ ����� ù ��° �ڽ� ���� �����Ѵ�.
	
	@method prependTo
	@syntax sId
	@syntax vElement
	@param {String+} sId ù ��° �ڽ� ��尡 ���� �� HTML ����� ID
	@param {Element+ | Node} vElement ù ��° �ڽ� ��尡 ���� �� HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#append
	@see nv.$Element#prepend
	@see nv.$Element#before
	@see nv.$Element#after
	@see nv.$Element#appendTo
	@see nv.$Element#wrap
	@example
		// ID�� sample2�� HTML ��ҿ�
		// ID�� sample1�� HTML ��Ҹ� �߰�
		$Element("sample1").prependTo("sample2");
		
		//Before
		<div id="sample1">
		    <div>Hello 1</div>
		</div>
		<div id="sample2">
		    <div>Hello 2</div>
		</div>
		
		//After
		<div id="sample2">
			<div id="sample1">
			    <div>Hello 1</div>
			</div>
		    <div>Hello 2</div>
		</div>
 */
nv.$Element.prototype.prependTo = function(oElement) {
    //-@@$Element.prependTo-@@//
    nv.$Element._prepend(nv.$Element._common(oElement,"prependTo"), this._element);
    return this;
};
//-!nv.$Element.prototype.prependTo end!-//

//-!nv.$Element.prototype.before start(nv.$Element._common)!-//
/**
 	before() �޼���� nv.$Element() ��ü�� �ִ� ����� ���� ���� ���(previousSibling)�� �Ķ���ͷ� ������ ��Ҹ� �����Ѵ�.
	
	@method before
	@syntax sId
	@syntax vElement
	@param {String+} sId ���� ���� ���� ������ HTML ����� ID
	@param {Element+ | Node} vElement ���� ���� ���� ������ HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#append
	@see nv.$Element#prepend
	@see nv.$Element#after
	@see nv.$Element#appendTo
	@see nv.$Element#prependTo
	@see nv.$Element#wrap
	@example
		// ID�� sample1�� HTML ��� �տ�
		// ID�� sample2�� HTML ��Ҹ� �߰� ��
		$Element("sample1").before("sample2"); // sample2�� ������ $Element �� ��ȯ
		
		//Before
		<div id="sample1">
		    <div>Hello 1</div>
			<div id="sample2">
			    <div>Hello 2</div>
			</div>
		</div>
		
		//After
		<div id="sample2">
			<div>Hello 2</div>
		</div>
		<div id="sample1">
		  <div>Hello 1</div>
		</div>
	@example
		// ���ο� DIV ��Ҹ� �߰�
		var elNew = $("<div>Hello New</div>");
		$Element("sample").before(elNew); // elNew ��Ҹ� ������ $Element �� ��ȯ
		
		//Before
		<div id="sample">
			<div>Hello</div>
		</div>
		
		//After
		<div>Hello New</div>
		<div id="sample">
			<div>Hello</div>
		</div>
 */
nv.$Element.prototype.before = function(oElement) {
    //-@@$Element.before-@@//
    var o = nv.$Element._common(oElement,"before");

    this._element.parentNode.insertBefore(o, this._element);

    return this;
};
//-!nv.$Element.prototype.before end!-//

//-!nv.$Element.prototype.after start(nv.$Element.prototype.before, nv.$Element._common)!-//
/**
 	after() �޼���� nv.$Element() ��ü�� �ִ� ����� ���� ���� ���(nextSibling)�� �Ķ���ͷ� ������ ��Ҹ� �����Ѵ�.
	
	@method after
	@syntax sId
	@syntax vElement
	@param {String+} sId ���� ���� ���� ������ HTML ����� ID
	@param {Element+ | Node} vElement ���� ���� ���� ������ HTML ���(Element) �Ǵ� nv.$Element() ��ü�� �Ķ���ͷ� ������ �� �ִ�.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Element#append
	@see nv.$Element#prepend
	@see nv.$Element#before
	@see nv.$Element#appendTo
	@see nv.$Element#prependTo
	@see nv.$Element#wrap
	@example
		// ID�� sample1�� HTML ��� �ڿ�
		// ID�� sample2�� HTML ��Ҹ� �߰� ��
		$Element("sample1").after("sample2");  // sample2�� ������ $Element �� ��ȯ
		
		//Before
		<div id="sample1">
		    <div>Hello 1</div>
			<div id="sample2">
			    <div>Hello 2</div>
			</div>
		</div>
		
		//After
		<div id="sample1">
			<div>Hello 1</div>
		</div>
		<div id="sample2">
			<div>Hello 2</div>
		</div>
	@example
		// ���ο� DIV ��Ҹ� �߰�
		var elNew = $("<div>Hello New</div>");
		$Element("sample").after(elNew); // elNew ��Ҹ� ������ $Element �� ��ȯ
		
		//Before
		<div id="sample">
			<div>Hello</div>
		</div>
		
		//After
		<div id="sample">
			<div>Hello</div>
		</div>
		<div>Hello New</div>
 */
nv.$Element.prototype.after = function(oElement) {
    //-@@$Element.after-@@//
    oElement = nv.$Element._common(oElement,"after");
    this.before(oElement);
    nv.$Element(oElement).before(this);

    return this;
};
//-!nv.$Element.prototype.after end!-//

//-!nv.$Element.prototype.parent start!-//
/**
 	parent() �޼���� HTML ����� ���� ��忡 �ش��ϴ� ��Ҹ� �˻��Ѵ�.
	
	@method parent
	@param {Function+} [fCallback] ���� ����� �˻� ������ ������ �ݹ� �Լ�.<br>�Ķ���͸� �����ϸ� �θ� ��Ҹ� ��ȯ�ϰ�, �Ķ���ͷ� �ݹ� �Լ��� �����ϸ� �ݹ� �Լ��� ���� ����� true�� ��ȯ�ϴ� ���� ��Ҹ� ��ȯ�Ѵ�. �̶� �ݹ� �Լ��� ����� �迭�� ��ȯ�Ѵ�. �ݹ� �Լ��� �Ķ���ͷ� Ž�� ���� ���� ����� nv.$Element() ��ü�� �Էµȴ�.
	@param {Numeric} [nLimit] Ž���� ���� ����� ����.<br>�Ķ���͸� �����ϸ� ��� ���� ��Ҹ� Ž���Ѵ�. fCallback �Ķ���͸� null�� �����ϰ� nLimit �Ķ���͸� �����ϸ� ���ѵ� ������ ���� ��Ҹ� ���Ǿ��� �˻��Ѵ�.
	@return {Variant} �θ� ��Ұ� ��� nv.$Element() ��ü Ȥ�� ������ �����ϴ� ���� ����� �迭(Array).<br>�Ķ���͸� �����Ͽ� �θ� ��Ҹ� ��ȯ�ϴ� ���, nv.$Element() ��ü�� ��ȯ�ϰ� �� �̿ܿ��� nv.$Element() ��ü�� ���ҷ� ���� �迭�� ��ȯ�Ѵ�.
	@see nv.$Element#child
	@see nv.$Element#prev
	@see nv.$Element#next
	@see nv.$Element#first
	@see nv.$Element#last
	@see nv.$Element#indexOf
	@example
		<div class="sample" id="div1">
			<div id="div2">
				<div class="sample" id="div3">
					<div id="target">
						Sample
						<div id="div4">
							Sample
						</div>
						<div class="sample" id="div5">
							Sample
						</div>
					</div>
					<div class="sample" id="div6">
						Sample
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var welTarget = $Element("target");
			var parent = welTarget.parent();
			// ID�� div3�� DIV�� ������ $Element�� ��ȯ
		
			parent = welTarget.parent(function(v){
			        return v.hasClass("sample");
			    });
			// ID�� div3�� DIV�� ������ $Element��
			// ID�� div1�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		
			parent = welTarget.parent(function(v){
			        return v.hasClass("sample");
			    }, 1);
			// ID�� div3�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		</script>
 */
nv.$Element.prototype.parent = function(pFunc, limit) {
    //-@@$Element.parent-@@//
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [],
        '4fun' : [ 'fpFunc:Function+' ],
        '4nul' : [ 'fpFunc:Null' ],
        'for_function_number' : [ 'fpFunc:Function+', 'nLimit:Numeric'],
        'for_null_number' : [ 'fpFunc:Null', 'nLimit:Numeric' ]
    },"$Element#parent");
    
    var e = this._element;
    
    switch(oArgs+""){
        case "4voi":
            return e.parentNode?nv.$Element(e.parentNode):null;
        case "4fun":
        case "4nul":
             limit = -1;
             break;
        case "for_function_number":
        case "for_null_number":
            if(oArgs.nLimit==0)limit = -1; 
    }

    var a = [], p = null;

    while(e.parentNode && limit-- != 0) {
        try {
            p = nv.$Element(e.parentNode);
        } catch(err) {
            p = null;
        }

        if (e.parentNode == document.documentElement) break;
        if (!pFunc || (pFunc && pFunc.call(this,p))) a[a.length] = p;

        e = e.parentNode;
    }

    return a;
};
//-!nv.$Element.prototype.parent end!-//

//-!nv.$Element.prototype.child start!-//
/**
 	child() �޼���� HTML ����� ���� ��忡 �ش��ϴ� ��Ҹ� �˻��Ѵ�.
	
	@method child
	@param {Function+} [fCallback] ���� ����� �˻� ������ ������ �ݹ� �Լ�.<br>�Ķ���͸� �����ϸ� �ڽ� ��Ҹ� ��ȯ�ϰ�, �Ķ���ͷ� �ݹ� �Լ��� �����ϸ� �ݹ� �Լ��� ���� ����� true�� ��ȯ�ϴ� ���� ��Ҹ� ��ȯ�Ѵ�. �̶� �ݹ� �Լ��� ����� �迭�� ��ȯ�Ѵ�. �ݹ� �Լ��� �Ķ���ͷ� Ž�� ���� ���� ����� nv.$Element() ��ü�� �Էµȴ�.
	@param {Numeric} [nLimit] Ž���� ���� ����� ����.<br>�Ķ���͸� �����ϸ� ��� ���� ��Ҹ� Ž���Ѵ�. fCallback �Ķ���͸� null�� �����ϰ� nLimit �Ķ���͸� �����ϸ� ���ѵ� ������ ���� ��Ҹ� ���Ǿ��� �˻��Ѵ�.
	@return {Variant} �ڽ� ��Ұ� ��� �迭(Array) Ȥ�� ������ �����ϴ� ���� ����� �迭(Array).<br>�ϳ��� ���� ��Ҹ� ��ȯ�� ���� nv.$Element() ��ü�� ��ȯ�ϰ� �� �̿ܿ��� nv.$Element() ��ü�� ���ҷ� ���� �迭�� ��ȯ�Ѵ�.
	@see nv.$Element#parent
	@see nv.$Element#prev
	@see nv.$Element#next
	@see nv.$Element#first
	@see nv.$Element#last
	@see nv.$Element#indexOf
	@example
		<div class="sample" id="target">
			<div id="div1">
				<div class="sample" id="div2">
					<div id="div3">
						Sample
						<div id="div4">
							Sample
						</div>
						<div class="sample" id="div5">
							Sample
							<div class="sample" id="div6">
								Sample
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="sample" id="div7">
				Sample
			</div>
		</div>
		
		<script type="text/javascript">
			var welTarget = $Element("target");
			var child = welTarget.child();
			// ID�� div1�� DIV�� ������ $Element��
			// ID�� div7�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		
			child = welTarget.child(function(v){
			        return v.hasClass("sample");
			    });
			// ID�� div2�� DIV�� ������ $Element��
			// ID�� div5�� DIV�� ������ $Element��
			// ID�� div6�� DIV�� ������ $Element��
			// ID�� div7�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		
			child = welTarget.child(function(v){
			        return v.hasClass("sample");
			    }, 1);
			// ID�� div7�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		
			child = welTarget.child(function(v){
			        return v.hasClass("sample");
			    }, 2);
			// ID�� div2�� DIV�� ������ $Element��
			// ID�� div7�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		</script>
 */
nv.$Element.prototype.child = function(pFunc, limit) {
    //-@@$Element.child-@@//
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [],
        '4fun' : [ 'fpFunc:Function+' ],
        '4nul' : [ 'fpFunc:Null' ],
        'for_function_number' : [ 'fpFunc:Function+', 'nLimit:Numeric'],
        'for_null_number' : [ 'fpFunc:Null', 'nLimit:Numeric' ]
    },"$Element#child");
    var e = this._element;
    var a = [], c = null, f = null;
    
    switch(oArgs+""){
        case "4voi":
            var child = e.childNodes;
            var filtered = [];

            for(var  i = 0, l = child.length; i < l; i++){
                if(child[i].nodeType == 1){
                    try {
                        filtered.push(nv.$Element(child[i]));
                    } catch(err) {
                        filtered.push(null);
                    }
                }
            }
            return filtered;
        case "4fun":
        case "4nul":
             limit = -1;
             break;
        case "for_function_number":
        case "for_null_number":
            if(oArgs.nLimit==0)limit = -1;
    }

    (f = function(el, lim, context) {
        var ch = null, o = null;

        for(var i=0; i < el.childNodes.length; i++) {
            ch = el.childNodes[i];
            if (ch.nodeType != 1) continue;
            try {
                o = nv.$Element(el.childNodes[i]);
            } catch(e) {
                o = null;
            }
            if (!pFunc || (pFunc && pFunc.call(context,o))) a[a.length] = o;
            if (lim != 0) f(el.childNodes[i], lim-1);
        }
    })(e, limit-1,this);

    return a;
};
//-!nv.$Element.prototype.child end!-//

//-!nv.$Element.prototype.prev start!-//
/**
 	prev() �޼���� HTML ����� ���� ���� ��忡 �ش��ϴ� ��Ҹ� �˻��Ѵ�.
	
	@method prev
	@param {Function+} [fCallback] ���� ���� ����� �˻� ������ ������ �ݹ� �Լ�.<br>�Ķ���ͷ� �ݹ� �Լ��� �����ϸ� �ݹ� �Լ��� ���� ����� true�� ��ȯ�ϴ� ���� ���� ��Ҹ� ��ȯ�Ѵ�. �̶� �ݹ� �Լ��� ����� �迭�� ��ȯ�Ѵ�. �ݹ� �Լ��� �Ķ���ͷ� Ž�� ���� ���� ���� ����� nv.$Element() ��ü�� �Էµȴ�.
	@return {Variant} ������ �����ϴ� ���� ���� ���(nv.$Element() ��ü)�� ���ҷ� ���� �迭(Array).<br>fCallback�� null�� ��� ��� ���� ���� ����� �迭(Array)�� ��ȯ�Ѵ�. �Ķ���͸� �����ϸ� �ٷ� ���� ���� ��Ұ� ��� nv.$Element() ��ü. ���� ������Ʈ�� ������ null�� ��ȯ�Ѵ�.
	@see nv.$Element#parent
	@see nv.$Element#child
	@see nv.$Element#next
	@see nv.$Element#first
	@see nv.$Element#last
	@see nv.$Element#indexOf
	@example
		<div class="sample" id="sample_div1">
			<div id="sample_div2">
				<div class="sample" id="sample_div3">
					Sample1
				</div>
				<div id="sample_div4">
					Sample2
				</div>
				<div class="sample" id="sample_div5">
					Sample3
				</div>
				<div id="sample_div">
					Sample4
					<div id="sample_div6">
						Sample5
					</div>
				</div>
				<div id="sample_div7">
					Sample6
				</div>
				<div class="sample" id="sample_div8">
					Sample7
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var sibling = $Element("sample_div").prev();
			// ID�� sample_div5�� DIV�� ������ $Element�� ��ȯ
		
			sibling = $Element("sample_div").prev(function(v){
			    return $Element(v).hasClass("sample");
			});
			// ID�� sample_div5�� DIV�� ������ $Element��
			// ID�� sample_div3�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		</script>
 */
nv.$Element.prototype.prev = function(pFunc) {
    //-@@$Element.prev-@@//
    
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [],
        '4fun' : [ 'fpFunc:Function+' ],
        '4nul' : [ 'fpFunc:Null' ]
    },"$Element#prev");
    
    var e = this._element;
    var a = [];
    
    switch(oArgs+""){
        case "4voi":
            if (!e) return null;
            do {
                
                e = e.previousSibling;
                if (!e || e.nodeType != 1) continue;
                try{
                    if(e==null) return null;
                    return nv.$Element(e);   
                }catch(e){
                    return null;
                }
            } while(e);
            try{
                if(e==null) return null;
                return nv.$Element(e);   
            }catch(e){
                return null;
            }
            // 'break' statement was intentionally omitted.
        case "4fun":
        case "4nul":
            if (!e) return a;
            do {
                e = e.previousSibling;
                
                if (!e || e.nodeType != 1) continue;
                if (!pFunc||pFunc.call(this,e)) {
                    
                    try{
                        if(e==null) a[a.length]=null;
                        else a[a.length] = nv.$Element(e);
                    }catch(e){
                        a[a.length] = null;
                    }
                     
                }
            } while(e);
            try{
                return a;   
            }catch(e){
                return null;
            }
    }
};
//-!nv.$Element.prototype.prev end!-//

//-!nv.$Element.prototype.next start!-//
/**
 	next() �޼���� HTML ����� ���� ���� ��忡 �ش��ϴ� ��Ҹ� �˻��Ѵ�.
	
	@method next
	@param {Function+} [fCallback] ���� ���� ����� �˻� ������ ������ �ݹ� �Լ�.<br>�Ķ���ͷ� �ݹ� �Լ��� �����ϸ� �ݹ� �Լ��� ���� ����� true�� ��ȯ�ϴ� ���� ���� ��Ҹ� ��ȯ�Ѵ�. �̶� �ݹ� �Լ��� ����� �迭�� ��ȯ�Ѵ�. �ݹ� �Լ��� �Ķ���ͷ� Ž�� ���� ���� ���� ����� nv.$Element() ��ü�� �Էµȴ�.
	@return {Variant} ������ �����ϴ� ���� ���� ���(nv.$Element() ��ü)�� ���ҷ� ���� �迭(Array).<br>fCallback�� null�� ��� ��� ���� ���� ����� �迭(Array)�� ��ȯ�Ѵ�. �Ķ���͸� �����ϸ� �ٷ� ���� ���� ��Ұ� ��� nv.$Element() ��ü. ���� ������Ʈ�� ������ null�� ��ȯ�Ѵ�.
	@see nv.$Element#parent
	@see nv.$Element#child
	@see nv.$Element#prev
	@see nv.$Element#first
	@see nv.$Element#last
	@see nv.$Element#indexOf
	@example
		<div class="sample" id="sample_div1">
			<div id="sample_div2">
				<div class="sample" id="sample_div3">
					Sample1
				</div>
				<div id="sample_div4">
					Sample2
				</div>
				<div class="sample" id="sample_div5">
					Sample3
				</div>
				<div id="sample_div">
					Sample4
					<div id="sample_div6">
						Sample5
					</div>
				</div>
				<div id="sample_div7">
					Sample6
				</div>
				<div class="sample" id="sample_div8">
					Sample7
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var sibling = $Element("sample_div").next();
			// ID�� sample_div7�� DIV�� ������ $Element�� ��ȯ
		
			sibling = $Element("sample_div").next(function(v){
			    return $Element(v).hasClass("sample");
			});
			// ID�� sample_div8�� DIV�� ������ $Element�� ���ҷ� �ϴ� �迭�� ��ȯ
		</script>
 */
nv.$Element.prototype.next = function(pFunc) {
    //-@@$Element.next-@@//
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [],
        '4fun' : [ 'fpFunc:Function+' ],
        '4nul' : [ 'fpFunc:Null' ]
    },"$Element#next");
    var e = this._element;
    var a = [];
    
    switch(oArgs+""){
        case "4voi":
            if (!e) return null;
            do {
                e = e.nextSibling;
                if (!e || e.nodeType != 1) continue;
                try{
                    if(e==null) return null;
                    return nv.$Element(e);   
                }catch(e){
                    return null;
                }
            } while(e);
            try{
                if(e==null) return null;
                return nv.$Element(e);   
            }catch(e){
                return null;
            }
            // 'break' statement was intentionally omitted.
        case "4fun":
        case "4nul":
            if (!e) return a;
            do {
                e = e.nextSibling;
                
                if (!e || e.nodeType != 1) continue;
                if (!pFunc||pFunc.call(this,e)) {
                    
                    try{
                        if(e==null) a[a.length] = null;
                        else a[a.length] = nv.$Element(e);
                    }catch(e){
                        a[a.length] = null;
                    }
                     
                }
            } while(e);
            try{
                return a;   
            }catch(e){
                return null;
            }
            
    }
};
//-!nv.$Element.prototype.next end!-//

//-!nv.$Element.prototype.first start!-//
/**
 	first() �޼���� HTML ����� ù ��° �ڽ� ��忡 �ش��ϴ� ��Ҹ� ��ȯ�Ѵ�.
	
	@method first
	@return {nv.$Element} ù ��° �ڽ� ��忡 �ش��ϴ� ���. ���� ������Ʈ�� ������ null�� ��ȯ.
	@since 1.2.0
	@see nv.$Element#parent
	@see nv.$Element#child
	@see nv.$Element#prev
	@see nv.$Element#next
	@see nv.$Element#last
	@see nv.$Element#indexOf
	@example
		<div id="sample_div1">
			<div id="sample_div2">
				<div id="sample_div">
					Sample1
					<div id="sample_div3">
						<div id="sample_div4">
							Sample2
						</div>
						Sample3
					</div>
					<div id="sample_div5">
						Sample4
						<div id="sample_div6">
							Sample5
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var firstChild = $Element("sample_div").first();
			// ID�� sample_div3�� DIV�� ������ $Element�� ��ȯ
		</script>
 */
nv.$Element.prototype.first = function() {
    //-@@$Element.first-@@//
    var el = this._element.firstElementChild||this._element.firstChild;
    if (!el) return null;
    while(el && el.nodeType != 1) el = el.nextSibling;
    try{
        return el?nv.$Element(el):null;
    }catch(e){
        return null;
    }
};
//-!nv.$Element.prototype.first end!-//

//-!nv.$Element.prototype.last start!-//
/**
 	last() �޼���� HTML ����� ������ �ڽ� ��忡 �ش��ϴ� ��Ҹ� ��ȯ�Ѵ�.
	
	@method last
	@return {nv.$Element} ������ �ڽ� ��忡 �ش��ϴ� ���. ���� ������Ʈ�� ������ null�� ��ȯ.
	@since 1.2.0
	@see nv.$Element#parent
	@see nv.$Element#child
	@see nv.$Element#prev
	@see nv.$Element#next
	@see nv.$Element#first
	@see nv.$Element#indexOf
	@example
		<div id="sample_div1">
			<div id="sample_div2">
				<div id="sample_div">
					Sample1
					<div id="sample_div3">
						<div id="sample_div4">
							Sample2
						</div>
						Sample3
					</div>
					<div id="sample_div5">
						Sample4
						<div id="sample_div6">
							Sample5
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var lastChild = $Element("sample_div").last();
			// ID�� sample_div5�� DIV�� ������ $Element�� ��ȯ
		</script>
 */
nv.$Element.prototype.last = function() {
    //-@@$Element.last-@@//
    var el = this._element.lastElementChild||this._element.lastChild;
    if (!el) return null;
    while(el && el.nodeType != 1) el = el.previousSibling;

    try{
        return el?nv.$Element(el):null;
    }catch(e){
        return null;
    }
};
//-!nv.$Element.prototype.last end!-//

//-!nv.$Element._contain.hidden start!-//
/**
 	isChildOf , isParentOf�� �⺻�� �Ǵ� API (IE������ contains,��Ÿ ���������� compareDocumentPosition�� ����ϰ� �Ѵ� ���� ���� ���� ���Ž� API���.)
	
	@method _contain
	@param {HTMLElement} eParent	�θ���
	@param {HTMLElement} eChild	�ڽĳ��
	@ignore
 */
nv.$Element._contain = function(eParent,eChild){
    if (document.compareDocumentPosition) {
        return !!(eParent.compareDocumentPosition(eChild)&16);
    }else if(eParent.contains){
        return (eParent !== eChild)&&(eParent.contains ? eParent.contains(eChild) : true);
    }else if(document.body.contains){
        if(eParent===(eChild.ownerDocument || eChild.document)&&eChild.tagName&&eChild.tagName.toUpperCase()==="BODY"){ return true;}  // when find body in document
        if(eParent.nodeType === 9&&eParent!==eChild){
            eParent = eParent.body; 
        }
        try{
            return (eParent !== eChild)&&(eParent.contains ? eParent.contains(eChild) : true);
        }catch(e){
            return false;
        }
    }else{
        var e  = eParent;
        var el = eChild;

        while(e && e.parentNode) {
            e = e.parentNode;
            if (e == el) return true;
        }
        return false;
    }
};
//-!nv.$Element._contain.hidden end!-//

//-!nv.$Element.prototype.isChildOf start(nv.$Element._contain)!-//
/**
 	isChildOf() �޼���� �Ķ���ͷ� ������ ��Ұ� HTML ����� �θ� ������� �˻��Ѵ�.
	
	@method isChildOf
	@syntax sElement
	@syntax elElement
	@param {String+} sElement �θ� ������� �˻��� HTML ����� ID
	@param {Element+} elElement �θ� ������� �˻��� HTML ���
	@return {Boolean} ������ ��Ұ� �θ� ����̸� true, �׷��� ������ false�� ��ȯ�Ѵ�.
	@see nv.$Element#isParentOf
	@example
		<div id="parent">
			<div id="child">
				<div id="grandchild"></div>
			</div>
		</div>
		<div id="others"></div>
		
		// �θ�/�ڽ� Ȯ���ϱ�
		$Element("child").isChildOf("parent");		// ��� : true
		$Element("others").isChildOf("parent");		// ��� : false
		$Element("grandchild").isChildOf("parent");	// ��� : true
 */
nv.$Element.prototype.isChildOf = function(element) {
    //-@@$Element.isChildOf-@@//
    try{
        return nv.$Element._contain(nv.$Element(element)._element,this._element);
    }catch(e){
        return false;
    }
};
//-!nv.$Element.prototype.isChildOf end!-//

//-!nv.$Element.prototype.isParentOf start(nv.$Element._contain)!-//
/**
 	isParentOf() �޼���� �Ķ���ͷ� ������ ��Ұ� HTML ����� �ڽ� ������� �˻��Ѵ�.
	
	@method isParentOf
	@syntax sElement
	@syntax elElement
	@param {String+} sElement �ڽ� ������� �˻��� HTML ����� ID
	@param {Element+} elElement �ڽ� ������� �˻��� HTML ���
	@return {Boolean} ������ ��Ұ� �ڽ� ����̸� true, �׷��� ������ false�� ��ȯ�Ѵ�.
	@see nv.$Element#isChildOf
	@example
		<div id="parent">
			<div id="child"></div>
		</div>
		<div id="others"></div>
		
		// �θ�/�ڽ� Ȯ���ϱ�
		$Element("parent").isParentOf("child");		// ��� : true
		$Element("others").isParentOf("child");		// ��� : false
		$Element("parent").isParentOf("grandchild");// ��� : true
 */
nv.$Element.prototype.isParentOf = function(element) {
    //-@@$Element.isParentOf-@@//
    try{
        return nv.$Element._contain(this._element, nv.$Element(element)._element);
    }catch(e){
        return false;
    }
};
//-!nv.$Element.prototype.isParentOf end!-//

//-!nv.$Element.prototype.isEqual start!-//
/**
 	isEqual() �޼���� �Ķ���ͷ� ������ ��Ұ� HTML ��ҿ� ���� ������� �˻��Ѵ�.
	
	@method isEqual
	@syntax sElement
	@syntax vElement
	@param {String+} sElement ���� ������� ���� HTML ����� ID.
	@param {Element+} vElement ���� ������� ���� HTML ���.
	@return {Boolean} ������ ��ҿ� ���� ����̸� true, �׷��� ������ false�� ��ȯ�Ѵ�.
	@remark 
		<ul class="disc">
			<li>DOM Level 3 ���� API �� isSameNode �Լ��� ���� �޼���� ���۷������� Ȯ���Ѵ�.</li>
			<li>isEqualNode() �޼���ʹ� �ٸ� �Լ��̱� ������ �����Ѵ�.</li>
		</ul>
	@see http://www.w3.org/TR/DOM-Level-3-Core/core.html#Node3-isSameNode isSameNode - W3C DOM Level 3 Specification
	@see nv.$Element#isEqualnode
	@example
		<div id="sample1"><span>Sample</span></div>
		<div id="sample2"><span>Sample</span></div>
		
		// ���� HTML ������� Ȯ��
		var welSpan1 = $Element("sample1").first();	// <span>Sample</span>
		var welSpan2 = $Element("sample2").first();	// <span>Sample</span>
		
		welSpan1.isEqual(welSpan2); // ��� : false
		welSpan1.isEqual(welSpan1); // ��� : true
 */
nv.$Element.prototype.isEqual = function(element) {
    //-@@$Element.isEqual-@@//
    try {
        return (this._element === nv.$Element(element)._element);
    } catch(e) {
        return false;
    }
};
//-!nv.$Element.prototype.isEqual end!-//

//-!nv.$Element.prototype.fireEvent start!-//
/**
 	fireEvent() �޼���� HTML ��ҿ� �̺�Ʈ�� �߻���Ų��. �Ķ���ͷ� �߻���ų �̺�Ʈ ������ �̺�Ʈ ��ü�� �Ӽ��� ������ �� �ִ�.
	
	@method fireEvent
	@param {String+} sEvent �߻���ų �̺�Ʈ �̸�. on ���λ�� �����Ѵ�.
	@param {Hash+} [oProps] �̺�Ʈ ��ü�� �Ӽ��� ������ ��ü. �̺�Ʈ�� �߻���ų �� �Ӽ��� ������ �� �ִ�.
	@return {nv.$Element} �̺�Ʈ�� �߻��� HTML ����� nv.$Element() ��ü.
	@remark 
		<ul class="disc">
			<li>1.4.1 �������� keyCode ���� ������ �� �ִ�.</li>
			<li>WebKit �迭������ �̺�Ʈ ��ü�� keyCode�� �б� ����(read-only)�� ����� key �̺�Ʈ�� �߻���ų ��� keyCode ���� ������ �� ������.</li>
		</ul>
	@example
		// click �̺�Ʈ �߻�
		$Element("div").fireEvent("click", {left : true, middle : false, right : false});
		
		// mouseover �̺�Ʈ �߻�
		$Element("div").fireEvent("mouseover", {screenX : 50, screenY : 50, clientX : 50, clientY : 50});
		
		// keydown �̺�Ʈ �߻�
		$Element("div").fireEvent("keydown", {keyCode : 13, alt : true, shift : false ,meta : false, ctrl : true});
 */
nv.$Element.prototype.fireEvent = function(sEvent, oProps) {
    //-@@$Element.fireEvent-@@//
    var _oParam = {
            '4str' : [ nv.$Jindo._F('sEvent:String+') ],
            '4obj' : [ 'sEvent:String+', 'oProps:Hash+' ]
    };
    
    nv._p_.fireCustomEvent = function (ele, sEvent,self,bIsNormalType){
        var oInfo = nv._p_.normalCustomEvent[sEvent];
        var targetEle,oEvent;
        for(var i in oInfo){
            oEvent = oInfo[i];
            targetEle = oEvent.ele;
            var wrap_listener;
            for(var sCssquery in oEvent){
                if(sCssquery==="_NONE_"){
                    if(targetEle==ele || self.isChildOf(targetEle)){
                        wrap_listener = oEvent[sCssquery].wrap_listener;
                        for(var k = 0, l = wrap_listener.length; k < l;k++){
                            wrap_listener[k]();
                        }
                    }
                }else{
                    if(nv.$Element.eventManager.containsElement(targetEle, ele, sCssquery,false)){
                        wrap_listener = oEvent[sCssquery].wrap_listener;
                        for(var k = 0, l = wrap_listener.length; k < l;k++){
                            wrap_listener[k]();
                        }
                    }
                }
            }
        }
        
    };

    function IE(sEvent, oProps) {
        var oArgs = g_checkVarType(arguments, _oParam,"$Element#fireEvent");
        var ele = this._element;
        
        if(nv._p_.normalCustomEvent[sEvent]){
            nv._p_.fireCustomEvent(ele,sEvent,this,!!nv._p_.normalCustomEvent[sEvent]);
            return this;
        }
    
        sEvent = (sEvent+"").toLowerCase();
        var oEvent = document.createEventObject();
        
        switch(oArgs+""){
            case "4obj":
                oProps = oArgs.oProps;
                for (var k in oProps){
                    if(oProps.hasOwnProperty(k))
                        oEvent[k] = oProps[k];
                } 
                oEvent.button = (oProps.left?1:0)+(oProps.middle?4:0)+(oProps.right?2:0);
                oEvent.relatedTarget = oProps.relatedElement||null;
                
        }

        if(this.tag == "input" && sEvent == "click"){ 
            if(ele.type=="checkbox"){ 
                ele.checked = (!ele.checked); 
            }else if(ele.type=="radio"){ 
                ele.checked = true; 
            } 
        } 
                
        this._element.fireEvent("on"+sEvent, oEvent);
        return this;
    }

    function DOM2(sEvent, oProps) {
        var oArgs = g_checkVarType(arguments, _oParam,"$Element#fireEvent");
        var ele = this._element;
        
        var oldEvent = sEvent;
        sEvent = nv.$Element.eventManager.revisionEvent("",sEvent,sEvent);
        if(nv._p_.normalCustomEvent[sEvent]){
            nv._p_.fireCustomEvent(ele,sEvent,this,!!nv._p_.normalCustomEvent[sEvent]);
            return this;
        }
        
        var sType = "HTMLEvents";
        sEvent = (sEvent+"").toLowerCase();
        

        if (sEvent == "click" || sEvent.indexOf("mouse") == 0) {
            sType = "MouseEvent";
        } else if(oldEvent.indexOf("wheel") > 0){
           sEvent = "DOMMouseScroll"; 
           sType = nv._p_._JINDO_IS_FF?"MouseEvent":"MouseWheelEvent";  
        } else if (sEvent.indexOf("key") == 0) {
            sType = "KeyboardEvent";
        } else if (sEvent.indexOf("pointer") > 0) {
            sType = "MouseEvent";
            sEvent = oldEvent;
        }
        
        var evt;
        switch (oArgs+"") {
            case "4obj":
                oProps = oArgs.oProps;
                oProps.button = 0 + (oProps.middle?1:0) + (oProps.right?2:0);
                oProps.ctrl = oProps.ctrl||false;
                oProps.alt = oProps.alt||false;
                oProps.shift = oProps.shift||false;
                oProps.meta = oProps.meta||false;
                switch (sType) {
                    case 'MouseEvent':
                        evt = document.createEvent(sType);
    
                        evt.initMouseEvent( sEvent, true, true, null, oProps.detail||0, oProps.screenX||0, oProps.screenY||0, oProps.clientX||0, oProps.clientY||0, 
                                            oProps.ctrl, oProps.alt, oProps.shift, oProps.meta, oProps.button, oProps.relatedElement||null);
                        break;
                    case 'KeyboardEvent':
                        if (window.KeyEvent) {
                            evt = document.createEvent('KeyEvents');
                            evt.initKeyEvent(sEvent, true, true, window,  oProps.ctrl, oProps.alt, oProps.shift, oProps.meta, oProps.keyCode, oProps.keyCode);
                        } else {
                            try {
                                evt = document.createEvent("Events");
                            } catch (e){
                                evt = document.createEvent("UIEvents");
                            } finally {
                                evt.initEvent(sEvent, true, true);
                                evt.ctrlKey  = oProps.ctrl;
                                evt.altKey   = oProps.alt;
                                evt.shiftKey = oProps.shift;
                                evt.metaKey  = oProps.meta;
                                evt.keyCode = oProps.keyCode;
                                evt.which = oProps.keyCode;
                            }          
                        }
                        break;
                    default:
                        evt = document.createEvent(sType);
                        evt.initEvent(sEvent, true, true);              
                }
            break;
            case "4str":
                evt = document.createEvent(sType);          
                evt.initEvent(sEvent, true, true);
            
        }
        ele.dispatchEvent(evt);
        return this;
    }
    nv.$Element.prototype.fireEvent =  (document.dispatchEvent !== undefined)?DOM2:IE;
    return this.fireEvent.apply(this,nv._p_._toArray(arguments));
};
//-!nv.$Element.prototype.fireEvent end!-//

//-!nv.$Element.prototype.empty start(nv.$Element.prototype.html)!-//
/**
 	empty() �޼���� HTML ����� �ڽ� ��ҿ� �� �ڽ� ��ҵ鿡 ��ϵ� ��� �̺�Ʈ �ڵ鷯���� �����Ѵ�.
	
	@method empty
	@return {this} �ڽ� ��带 ��� ������ �ν��Ͻ� �ڽ�
	@see nv.$Element#leave
	@see nv.$Element#remove
	@example
		// �ڽ� ��带 ��� ����
		$Element("sample").empty();
		
		//Before
		<div id="sample"><span>���</span> <span>���</span> �����ϱ� </div>
		
		//After
		<div id="sample"></div>
 */
nv.$Element.prototype.empty = function() {
    //-@@$Element.empty-@@//
    if(nv.cssquery) nv.cssquery.release();
    this.html("");
    return this;
};
//-!nv.$Element.prototype.empty end!-//

//-!nv.$Element.prototype.remove start(nv.$Element.prototype.leave, nv.$Element._common)!-//
/**
 	remove() �޼���� HTML ����� Ư�� �ڽ� ��带 �����Ѵ�. �Ķ���ͷ� ������ �ڽ� ��Ҹ� �����ϸ� ���ŵǴ� �ڽ� ����� �̺�Ʈ �ڵ鷯�� �� �ڽ� ����� ��� ���� ����� ��� �̺�Ʈ �ڵ鷯�� �����Ѵ�.
	
	@method remove
	@syntax sElement
	@syntax vElement
	@param {String+} sElement �ڽ� ��ҿ��� ������ HTML ����� ID.
	@param {Element+} vElement �ڽ� ��ҿ��� ������ HTML ���.
	@return {this} ������ �ڽ� ��带 ������ �ν��Ͻ� �ڽ�
	@see nv.$Element#empty
	@see nv.$Element#leave
	@example
		// Ư�� �ڽ� ��带 ����
		$Element("sample").remove("child2");
		
		//Before
		<div id="sample"><span id="child1">���</span> <span id="child2">�����ϱ�</span></div>
		
		//After
		<div id="sample"><span id="child1">���</span> </div>
 */
nv.$Element.prototype.remove = function(oChild) {
    //-@@$Element.remove-@@//
    if(nv.cssquery) nv.cssquery.release();
    var ___element = nv.$Element;
    ___element(___element._common(oChild,"remove")).leave();
    return this;
};
//-!nv.$Element.prototype.remove end!-//

//-!nv.$Element.prototype.leave start(nv.$Element.event_etc)!-//
/**
 	leave() �޼���� HTML ��Ҹ� �ڽ��� �θ� ��ҿ��� �����Ѵ�. HTML ��ҿ� ��ϵ� �̺�Ʈ �ڵ鷯, �׸��� �� ����� ��� �ڽĿ���� ��� �̺�Ʈ �ڵ鷯�� �����Ѵ�.
	
	@method leave
	@return {this} �θ� ��ҿ��� ���ŵ� �ν��Ͻ� �ڽ�
	@see nv.$Element#empty
	@see nv.$Element#remove
	@example
		// �θ� ��� ��忡�� ����
		$Element("sample").leave();
		
		//Before
		<div>
			<div id="sample"><span>���</span> <span>���</span> �����ϱ� </div>
		</div>
		
		//After : <div id="sample"><span>���</span> <span>���</span> �����ϱ� </div>�� ������ $Element�� ��ȯ�ȴ�
		<div>
		
		</div>
 */
nv.$Element.prototype.leave = function() {
    //-@@$Element.leave-@@//
    var e = this._element;
    
    if(e.parentNode){
        if(nv.cssquery) nv.cssquery.release();
        e.parentNode.removeChild(e);
    }
    
    /*if(this._element.__nv__id){
        nv.$Element.eventManager.cleanUpUsingKey(this._element.__nv__id, true);
    }

    nv._p_.releaseEventHandlerForAllChildren(this);*/
    
    return this;
};
//-!nv.$Element.prototype.leave end!-//

//-!nv.$Element.prototype.wrap start(nv.$Element._common)!-//
/**
 	wrap() �޼���� HTML ��Ҹ� ������ ��ҷ� ���Ѵ�. HTML ��Ҵ� ������ ����� ������ �ڽ� ��Ұ� �ȴ�.
	
	@method wrap
	@syntax sElement
	@syntax vElement
	@param {String+} sElement �θ� �� HTML ����� ID.
	@param {Element+ | Node} vElement �θ� �� HTML ���.
	@return {nv.$Element} ������ ��ҷ� ������ nv.$Element() ��ü.
	@example
		$Element("sample1").wrap("sample2");
		
		//Before
		<div id="sample1"><span>Sample</span></div>
		<div id="sample2"><span>Sample</span></div>
		
		//After
		<div id="sample2"><span>Sample</span><div id="sample1"><span>Sample</span></div></div>
	@example
		$Element("box").wrap($('<DIV>'));
		
		//Before
		<span id="box"></span>
		
		//After
		<div><span id="box"></span></div>
 */
nv.$Element.prototype.wrap = function(wrapper) {
    //-@@$Element.wrap-@@//
    var e = this._element;
    wrapper = nv.$Element._common(wrapper,"wrap");
    if (e.parentNode) {
        e.parentNode.insertBefore(wrapper, e);
    }
    wrapper.appendChild(e);

    return this;
};
//-!nv.$Element.prototype.wrap end!-//

//-!nv.$Element.prototype.ellipsis start(nv.$Element.prototype._getCss,nv.$Element.prototype.text)!-//
/**
 	ellipsis() �޼���� HTML ����� �ؽ�Ʈ ��尡 ���������� �� �ٷ� ���̵��� ���̸� �����Ѵ�.
	
	@method ellipsis
	@param {String+} [sTail="..."] ������ ǥ����. �Ķ���Ϳ� ������ ���ڿ��� �ؽ�Ʈ ��� ���� ���̰� �ؽ�Ʈ ����� ���̸� �����Ѵ�.
	@return {this} �ν��Ͻ� �ڽ�
	@remark 
		<ul class="disc">
			<li>�� �޼���� HTML ��Ұ� �ؽ�Ʈ ��常�� �����Ѵٰ� �����ϰ� �����Ѵ�. ����, �� ���� ��Ȳ������ ����� �����Ѵ�.</li>
			<li>���������� HTML ����� �ʺ� �������� �ؽ�Ʈ ����� ���̸� ���ϹǷ� HTML ��Ҵ� �ݵ�� ���̴� ����(display)���� �Ѵ�. ȭ�鿡 ��ü �ؽ�Ʈ ��尡 �����ٰ� �پ��� ��찡 �ִ�. �� ���, HTML ��ҿ� overflow �Ӽ��� ���� hidden���� �����ϸ� �ذ��� �� �ִ�.</li>
		</ul>
	@example
		$Element("sample_span").ellipsis();
		
		//Before
		<div style="width:300px; border:1px solid #ccc padding:10px">
			<span id="sample_span">NHN�� �˻��� ������ �������� �������̰� ���� �¶��� ���񽺸� ������ �����̸� ������ �������� �����ϰ� �ֽ��ϴ�.</span>
		</div>
		
		//After
		<div style="width:300px; border:1px solid #ccc; padding:10px">
			<span id="sample_span">NHN�� �˻��� ������ �������� ������...</span>
		</div> 
 */
nv.$Element.prototype.ellipsis = function(stringTail) {
    //-@@$Element.ellipsis-@@//
    
    var oArgs = g_checkVarType(arguments, {
        '4voi' : [ ],
        '4str' : [ 'stringTail:String+' ]
    },"$Element#ellipsis");
    
    stringTail = stringTail || "...";
    var txt   = this.text();
    var len   = txt.length;
    var padding = parseInt(this._getCss(this._element,"paddingTop"),10) + parseInt(this._getCss(this._element,"paddingBottom"),10);
    var cur_h = this._element.offsetHeight - padding;
    var i     = 0;
    var h     = this.text('A')._element.offsetHeight - padding;

    if (cur_h < h * 1.5) {
        this.text(txt);
        return this;
    }

    cur_h = h;
    while(cur_h < h * 1.5) {
        i += Math.max(Math.ceil((len - i)/2), 1);
        cur_h = this.text(txt.substring(0,i)+stringTail)._element.offsetHeight - padding;
    }

    while(cur_h > h * 1.5) {
        i--;
        cur_h = this.text(txt.substring(0,i)+stringTail)._element.offsetHeight - padding;
    }
    return this;
};
//-!nv.$Element.prototype.ellipsis end!-//

//-!nv.$Element.prototype.indexOf start!-//
/**
 	indexOf() �޼���� HTML ��ҿ��� �Ķ���ͷ� ������ ��Ұ� �� ��° �ڽ����� Ȯ���Ͽ� �ε����� ��ȯ�Ѵ�.
	
	@method indexOf
	@syntax sElement
	@syntax vElement
	@param {String+} sElement �� ��° �ڽ����� �˻��� ����� ID
	@param {Element+} vElement �� ��° �ڽ����� �˻��� ���.
	@return {Numeric} �˻� ��� �ε���. �ε����� 0���� �����ϸ�, ã�� ���� ��쿡�� -1 �� ��ȯ�Ѵ�.
	@since 1.2.0
	@see nv.$Element#parent
	@see nv.$Element#child
	@see nv.$Element#prev
	@see nv.$Element#next
	@see nv.$Element#first
	@see nv.$Element#last
	@example
		<div id="sample_div1">
			<div id="sample_div">
				<div id="sample_div2">
					Sample1
				</div>
				<div id="sample_div3">
					<div id="sample_div4">
						Sample2
					</div>
					Sample3
				</div>
				<div id="sample_div5">
					Sample4
					<div id="sample_div6">
						Sample5
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			var welSample = $Element("sample_div");
			welSample.indexOf($Element("sample_div1"));	// ��� : -1
			welSample.indexOf($Element("sample_div2"));	// ��� : 0
			welSample.indexOf($Element("sample_div3"));	// ��� : 1
			welSample.indexOf($Element("sample_div4"));	// ��� : -1
			welSample.indexOf($Element("sample_div5"));	// ��� : 2
			welSample.indexOf($Element("sample_div6"));	// ��� : -1
		</script>
 */
nv.$Element.prototype.indexOf = function(element) {
    //-@@$Element.indexOf-@@//
    try {
        var e = nv.$Element(element)._element;
        var n = this._element.childNodes;
        var c = 0;
        var l = n.length;

        for (var i=0; i < l; i++) {
            if (n[i].nodeType != 1) continue;

            if (n[i] === e) return c;
            c++;
        }
    }catch(e){}

    return -1;
};
//-!nv.$Element.prototype.indexOf end!-//

//-!nv.$Element.prototype.queryAll start(nv.cssquery)!-//
/**
 	queryAll() �޼���� HTML ��ҿ��� Ư�� CSS ������(CSS Selector)�� �����ϴ� ���� ��Ҹ� ã�´�.
	
	@method queryAll
	@param {String+} sSelector CSS ������. CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS Level3 ������ �ִ� ������ �����Ѵ�.
	@return {Array} CSS ������ ������ �����ϴ� HTML ���(nv.$Element() ��ü)�� �迭�� ��ȯ�Ѵ�. �����ϴ� HTML ��Ұ� �������� ������ �� �迭�� ��ȯ�Ѵ�.
	@see nv.$Element#query
	@see nv.$Element#queryAll
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
	@example
		<div id="sample">
			<div></div>
			<div class="pink"></div>
			<div></div>
			<div class="pink"></div>
			<div></div>
			<div class="blue"></div>
			<div class="blue"></div>
		</div>
		
		<script type="text/javascript">
			$Element("sample").queryAll(".pink");
			// <div class="pink"></div>�� <div class="pink"></div>�� ���ҷ� �ϴ� �迭�� ��ȯ
		
			$Element("sample").queryAll(".green");
			// [] �� �迭�� ��ȯ
		</script>
 */
nv.$Element.prototype.queryAll = function(sSelector) { 
    //-@@$Element.queryAll-@@//
    var oArgs = g_checkVarType(arguments, {
        '4str'  : [ 'sSelector:String+']
    },"$Element#queryAll");

    var arrEle = nv.cssquery(sSelector, this._element);
    var returnArr = [];
    for(var i = 0, l = arrEle.length; i < l; i++){
        returnArr.push(nv.$Element(arrEle[i]));
    }
    return returnArr; 
};
//-!nv.$Element.prototype.queryAll end!-//

//-!nv.$Element.prototype.query start(nv.cssquery)!-//
/**
 	query() �޼���� HTML ��ҿ��� Ư�� CSS ������(CSS Selector)�� �����ϴ� ù ��° ���� ��Ҹ� ��ȯ�Ѵ�.
	
	@method query
	@param {String+} sSelector CSS ������. CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS Level3 ������ �ִ� ������ �����Ѵ�.
	@return {nv.$Element} CSS �������� ������ �����ϴ� ù ��° HTML ����� $Element�ν��Ͻ�. �����ϴ� HTML ��Ұ� �������� ������ null�� ��ȯ�Ѵ�.
	@see nv.$Element#test
	@see nv.$Element#queryAll
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
	@example
		<div id="sample">
			<div></div>
			<div class="pink"></div>
			<div></div>
			<div class="pink"></div>
			<div></div>
			<div class="blue"></div>
			<div class="blue"></div>
		</div>
		
		<script type="text/javascript">
			$Element("sample").query(".pink");
			// ù ��° <div class="pink"></div> DIV ��Ҹ� ��ȯ
		
			$Element("sample").query(".green");
			// null �� ��ȯ
		</script>
 */
nv.$Element.prototype.query = function(sSelector) { 
    //-@@$Element.query-@@//
    var oArgs = g_checkVarType(arguments, {
        '4str'  : [ 'sSelector:String+']
    },"$Element#query");
    var ele =  nv.cssquery.getSingle(sSelector, this._element);
    return ele === null? ele : nv.$Element(ele); 
};
//-!nv.$Element.prototype.query end!-//

//-!nv.$Element.prototype.test start(nv.cssquery)!-//
/**
 	test() �޼���� HTML ��ҿ��� Ư�� CSS ������(CSS Selector)�� �����ϴ��� Ȯ���Ѵ�.
	
	@method test
	@param {String+} sSelector CSS ������. CSS �����ڷ� ����� �� �ִ� ������ ǥ�� ���ϰ� ��ǥ�� ������ �ִ�. ǥ�� ������ CSS Level3 ������ �ִ� ������ �����Ѵ�.
	@return {Boolean} CSS �������� ������ �����ϸ� true, �׷��� ������ false�� ��ȯ�Ѵ�.
	@see nv.$Element#query
	@see nv.$Element#queryAll
	@see http://www.w3.org/TR/css3-selectors/ CSS Level3 ���� - W3C
	@example
		<div id="sample" class="blue"></div>
		
		<script type="text/javascript">
			$Element("sample").test(".blue");	// ��� : true
			$Element("sample").test(".red");	// ��� : false
		</script>
 */
nv.$Element.prototype.test = function(sSelector) {
    //-@@$Element.test-@@// 
    var oArgs = g_checkVarType(arguments, {
        '4str'  : [ 'sSelector:String+']
    },"$Element#test");
    return nv.cssquery.test(this._element, sSelector); 
};
//-!nv.$Element.prototype.test end!-//

//-!nv.$Element.prototype.xpathAll start(nv.cssquery)!-//
/**
 	xpathAll() �޼���� HTML ��Ҹ� �������� XPath ������ �����ϴ� ��Ҹ� �����´�.
	
	@method xpathAll
	@param {String+} sXPath XPath ��.
	@return {Array} XPath ������ �����ϴ� ���(nv.$Element() ��ü)�� ���ҷ� �ϴ� �迭.
	@remark �����ϴ� ������ �������̹Ƿ� Ư���� ��쿡�� ����� ���� �����Ѵ�.
	@see nv.$$
	@example
		<div id="sample">
			<div>
				<div>1</div>
				<div>2</div>
				<div>3</div>
				<div>4</div>
				<div>5</div>
				<div>6</div>
			</div>
		</div>
		
		<script type="text/javascript">
			$Element("sample").xpathAll("div/div[5]");
			// <div>5</div> ��Ҹ� ���ҷ� �ϴ� �迭�� ��ȯ ��
		</script>
 */
nv.$Element.prototype.xpathAll = function(sXPath) {
    //-@@$Element.xpathAll-@@// 
    var oArgs = g_checkVarType(arguments, {
        '4str'  : [ 'sXPath:String+']
    },"$Element#xpathAll");
    var arrEle = nv.cssquery.xpath(sXPath, this._element);
    var returnArr = [];
    for(var i = 0, l = arrEle.length; i < l; i++){
        returnArr.push(nv.$Element(arrEle[i]));
    }
    return returnArr; 
};
//-!nv.$Element.prototype.xpathAll end!-//

//-!nv.$Element.prototype.insertAdjacentHTML.hidden start!-//
/**
 	insertAdjacentHTML �Լ�. ����������� ����.
	
	@method insertAdjacentHTML
	@ignore
 */
nv.$Element.insertAdjacentHTML = function(ins,html,insertType,type,fn,sType){
    var aArg = [ html ];
    aArg.callee = arguments.callee;
    var oArgs = g_checkVarType(aArg, {
        '4str'  : [ 'sHTML:String+' ]
    },"$Element#"+sType);
    var _ele = ins._element;
    html = html+"";
    if( _ele.insertAdjacentHTML && !(/^<(option|tr|td|th|col)(?:.*?)>/.test(nv._p_.trim(html).toLowerCase()))){
        _ele.insertAdjacentHTML(insertType, html);
    }else{
        var oDoc = _ele.ownerDocument || _ele.document || document;
        var fragment = oDoc.createDocumentFragment();
        var defaultElement;
        var sTag = nv._p_.trim(html);
        var oParentTag = {
            "option" : "select",
            "tr" : "tbody",
            "thead" : "table",
            "tbody" : "table",
            "col" : "table",
            "td" : "tr",
            "th" : "tr",
            "div" : "div"
        };
        var aMatch = /^<(option|tr|thead|tbody|td|th|col)(?:.*?)\>/i.exec(sTag);
        var sChild = aMatch === null ? "div" : aMatch[1].toLowerCase();
        var sParent = oParentTag[sChild] ;
        defaultElement = nv._p_._createEle(sParent,sTag,oDoc,true);
        var scripts = defaultElement.getElementsByTagName("script");
    
        for ( var i = 0, l = scripts.length; i < l; i++ ){
            scripts[i].parentNode.removeChild( scripts[i] );
        }

        if(_ele.tagName.toLowerCase() == "table" && !_ele.getElementsByTagName("tbody").length && !sTag.match(/<tbody[^>]*>/i)) {
            var elTbody = oDoc.createElement("tbody"),
                bTheadTfoot = sTag.match(/^<t(head|foot)[^>]*>/i);

            if(!bTheadTfoot) {
                fragment.appendChild(elTbody);
                fragment = elTbody;
            }
        }

        while ( defaultElement[ type ]){
            fragment.appendChild( defaultElement[ type ] );
        }
        
        bTheadTfoot && fragment.appendChild(elTbody);
        fn(fragment.cloneNode(true));
    }
    return ins;
};

//-!nv.$Element.prototype.insertAdjacentHTML.hidden end!-//

//-!nv.$Element.prototype.appendHTML start(nv.$Element.prototype.insertAdjacentHTML)!-//
/**
 	appendHTML() �޼���� ���� HTML �ڵ�(innerHTML)�� �ڿ� �Ķ���ͷ� ������ HTML �ڵ带 �����δ�.
	
	@method appendHTML
	@param {String+} sHTML ������ HTML ���ڿ�.
	@return {this} ���� HTML �ڵ带 ������ �ν��Ͻ� �ڽ�
	@remark 1.4.8 �������� nv.$Element() ��ü�� ��ȯ�Ѵ�.
	@since 1.4.6
	@see nv.$Element#prependHTML
	@see nv.$Element#beforeHTML
	@see nv.$Element#afterHTML
	@example
		// ���� HTML ���� �ڿ� �����̱�
		$Element("sample_ul").appendHTML("<li>3</li><li>4</li>");
		
		//Before
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
		
		//After
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
		</ul>
 */
nv.$Element.prototype.appendHTML = function(sHTML) {
    //-@@$Element.appendHTML-@@//
    return nv.$Element.insertAdjacentHTML(this,sHTML,"beforeEnd","firstChild",nv.$Fn(function(oEle) {
        var ele = this._element;

        if(ele.tagName.toLowerCase() === "table") {
            var nodes = ele.childNodes;

            for(var i=0,l=nodes.length; i < l; i++) {
                if(nodes[i].nodeType==1){
                    ele = nodes[i]; 
                    break;
                }
            }
        }
        ele.appendChild(oEle);
    },this).bind(),"appendHTML");
};
//-!nv.$Element.prototype.appendHTML end!-//

//-!nv.$Element.prototype.prependHTML start(nv.$Element.prototype.insertAdjacentHTML,nv.$Element._prepend)!-//
/**
 	prependHTML() �޼���� ���� HTML �ڵ�(innerHTML)�� �տ� �Ķ���ͷ� ������ HTML �ڵ带 �����Ѵ�.
	
	@method prependHTML
	@param {String+} sHTML ������ HTML ���ڿ�.
	@return {this} �ν��Ͻ� �ڽ�
	@remark 1.4.8 �������� nv.$Element() ��ü�� ��ȯ�Ѵ�.
	@since 1.4.6
	@see nv.$Element#appendHTML
	@see nv.$Element#beforeHTML
	@see nv.$Element#afterHTML
	@example
		// ���� HTML ���� �տ� ����
		$Element("sample_ul").prependHTML("<li>3</li><li>4</li>");
		
		//Before
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
		
		//After
		<ul id="sample_ul">
			<li>4</li>
			<li>3</li>
			<li>1</li>
			<li>2</li>
		</ul>
 */
nv.$Element.prototype.prependHTML = function(sHTML) {
    //-@@$Element.prependHTML-@@//
    var ___element = nv.$Element;

    return ___element.insertAdjacentHTML(this,sHTML,"afterBegin","firstChild",nv.$Fn(function(oEle) {
        var ele = this._element;
        if(ele.tagName.toLowerCase() === "table") {
            var nodes = ele.childNodes;
            for(var i=0,l=nodes.length; i < l; i++) {
                if(nodes[i].nodeType==1) {
                    ele = nodes[i]; 
                    break;
                }
            }
        }
        ___element._prepend(ele,oEle);
    },this).bind(),"prependHTML");
};
//-!nv.$Element.prototype.prependHTML end!-//

//-!nv.$Element.prototype.beforeHTML start(nv.$Element.prototype.insertAdjacentHTML)!-//
/**
 	beforeHTML() �޼���� HTML �ڵ�(outerHTML)�� �տ� �Ķ���ͷ� ������ HTML �ڵ带 �����Ѵ�.
	
	@method beforeHTML
	@param {String+} sHTML ������ HTML ���ڿ�.
	@return {this} �ν��Ͻ� �ڽ�
	@remark 1.4.8 ���� nv.$Element() ��ü�� ��ȯ�Ѵ�.
	@since 1.4.6
	@see nv.$Element#appendHTML
	@see nv.$Element#prependHTML
	@see nv.$Element#afterHTML
	@example
		var welSample = $Element("sample_ul");
		
		welSample.beforeHTML("<ul><li>3</li><li>4</li></ul>");
		welSample.beforeHTML("<ul><li>5</li><li>6</li></ul>");
		
		//Before
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
		
		//After
		<ul>
			<li>5</li>
			<li>6</li>
		</ul>
		<ul>
			<li>3</li>
			<li>4</li>
		</ul>
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
 */
nv.$Element.prototype.beforeHTML = function(sHTML) {
    //-@@$Element.beforeHTML-@@//
    return nv.$Element.insertAdjacentHTML(this,sHTML,"beforeBegin","firstChild",nv.$Fn(function(oEle){
        this._element.parentNode.insertBefore(oEle, this._element);
    },this).bind(),"beforeHTML");
};
//-!nv.$Element.prototype.beforeHTML end!-//

//-!nv.$Element.prototype.afterHTML start(nv.$Element.prototype.insertAdjacentHTML)!-//
/**
 	afterHTML() �޼���� HTML �ڵ�(outerHTML)�� �ڿ� �Ķ���ͷ� ������ HTML �ڵ带 �����Ѵ�.
	
	@method afterHTML
	@param {String+} sHTML ������ HTML ���ڿ�.
	@return {this} ���� HTML �ڵ带 ������ �ν��Ͻ� �ڽ�
	@since 1.4.8 �������� nv.$Element() ��ü�� ��ȯ�Ѵ�.
	@since 1.4.6
	@see nv.$Element#appendHTML
	@see nv.$Element#prependHTML
	@see nv.$Element#beforeHTML
	@example
		var welSample = $Element("sample_ul");
		
		welSample.afterHTML("<ul><li>3</li><li>4</li></ul>");
		welSample.afterHTML("<ul><li>5</li><li>6</li></ul>");
		
		//Before
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
		
		//After
		<ul id="sample_ul">
			<li>1</li>
			<li>2</li>
		</ul>
		<ul>
			<li>3</li>
			<li>4</li>
		</ul>
		<ul>
			<li>5</li>
			<li>6</li>
		</ul>
 */
nv.$Element.prototype.afterHTML = function(sHTML) {
    //-@@$Element.afterHTML-@@//
    return nv.$Element.insertAdjacentHTML(this,sHTML,"afterEnd","firstChild",nv.$Fn(function(oEle){
        this._element.parentNode.insertBefore( oEle, this._element.nextSibling );
    },this).bind(),"afterHTML");
};
//-!nv.$Element.prototype.afterHTML end!-//

//-!nv.$Element.prototype.hasEventListener start(nv.$Element.prototype.attach)!-//
/**
	������Ʈ�� �ش� �̺�Ʈ�� �Ҵ�Ǿ� �ִ����� Ȯ��.
	
	@method hasEventListener
	@param {String+} sEvent �̺�Ʈ��
	@return {Boolean} �̺�Ʈ �Ҵ� ����
	@remark 2.2.0 ��������, load�� domready�̺�Ʈ�� ���� Window�� Document���� �߻��ϴ� �̺�Ʈ������ ���θ� �����ؼ� ����Ͽ��� �̺�Ʈ�� �ùٸ��� �߻��Ѵ�.
	@since 2.0.0
	@example
		$Element("test").attach("click",function(){});
		
		$Element("test").hasEventListener("click"); //true
		$Element("test").hasEventListener("mousemove"); //false
 */
nv.$Element.prototype.hasEventListener = function(sEvent){

    var oArgs = g_checkVarType(arguments, {
        '4str' : [ 'sEvent:String+' ]
    },"$Element#hasEventListener"),
        oDoc,
        bHasEvent = false,
        sLowerCaseEvent = oArgs.sEvent.toLowerCase();
    
    if(this._key){
        oDoc = this._element.ownerDocument || this._element.document || document;
        
        if(sLowerCaseEvent == "load" && this._element === oDoc){
            bHasEvent = nv.$Element(window).hasEventListener(oArgs.sEvent);
        }else if(sLowerCaseEvent == "domready" && nv.$Jindo.isWindow(this._element)){
            bHasEvent = nv.$Element(oDoc).hasEventListener(oArgs.sEvent);
        }else{
            var realEvent = nv.$Element.eventManager.revisionEvent("", sEvent);
            bHasEvent = !!nv.$Element.eventManager.hasEvent(this._key, realEvent, oArgs.sEvent);
        }
        
        return bHasEvent;
    }
    
    return false;
};
//-!nv.$Element.prototype.hasEventListener end!-//

//-!nv.$Element.prototype.preventTapHighlight start(nv.$Element.prototype.addClass, nv.$Element.prototype.removeClass)!-//
/**
	����Ͽ��� �̺�Ʈ ��������Ʈ�� ��������� �θ� ������Ʈ�� ���̶���Ʈ�� �Ǵ� ���� ���´�.
	
	@method preventTapHighlight
	@param {Boolean} bType ���̶���Ʈ�� ������ ����
	@return {this} �ν��Ͻ� �ڽ�
	@since 2.0.0
	@example
		<ul id="test">
			<li><a href="#nhn">nhn</a></li>
			<li><a href="#naver">naver</a></li>
			<li><a href="#hangame">hangame</a></li>
		</ul>
		
		$Element("test").preventTapHighlight(true); // �̷��� �ϸ� ����Ͽ��� test�� ���̶���Ʈ�� �Ǵ� ���� ���´�.
		$Element("test").delegate("click","a",function(e){});
 */
nv.$Element.prototype.preventTapHighlight = function(bFlag){
    if(nv._p_._JINDO_IS_MO){
        var sClassName = 'no_tap_highlight' + new Date().getTime();
        
        var elStyleTag = document.createElement('style');
        var elHTML = document.getElementsByTagName('html')[0];
        
        elStyleTag.type = "text/css";
        
        elHTML.insertBefore(elStyleTag, elHTML.firstChild);
        var oSheet = elStyleTag.sheet || elStyleTag.styleSheet;
        
        oSheet.insertRule('.' + sClassName + ' { -webkit-tap-highlight-color: rgba(0,0,0,0); }', 0);
        oSheet.insertRule('.' + sClassName + ' * { -webkit-tap-highlight-color: rgba(0,0,0,.25); }', 0);
        
        nv.$Element.prototype.preventTapHighlight = function(bFlag) {
            return this[bFlag ? 'addClass' : 'removeClass'](sClassName);
        };
    }else{
        nv.$Element.prototype.preventTapHighlight = function(bFlag) { return this; };
    }
    return this.preventTapHighlight.apply(this,nv._p_._toArray(arguments));
};
//-!nv.$Element.prototype.preventTapHighlight end!-//


//-!nv.$Element.prototype.data start(nv.$Json._oldToString)!-//
/**
 	data() �޼���� dataset�� �Ӽ��� �����´�.
	
	@method data
	@param {String+} sName dataset �̸�
	@return {Variant} dataset ���� ��ȯ. set�� �� ���� Ÿ������ ��ȯ�ϰ�, �ش� �Ӽ��� ���ٸ� null�� ��ȯ�Ѵ�. ��, JSON.stringfly�� ��ȯ ���� undefined�� ���� �������� �ʴ´�.
	@see nv.$Element#attr
 */
/**
 	data() �޼���� dataset�� �Ӽ��� �����Ѵ�.
	
	@method data
	@syntax sName, vValue
	@syntax oList
	@param {String+} sName dataset �̸�.
	@param {Variant} vValue dataset�� ������ ��. dataset�� ���� null�� �����ϸ� �ش� dataset�� �����Ѵ�.
	@param {Hash+} oList �ϳ� �̻��� dataset�� ���� ������ ��ü(Object) �Ǵ� �ؽ� ��ü(nv.$H() ��ü).
	@return {this} dataset�� �Ӽ��� ������ �ν��Ͻ� �ڽ�
	@see nv.$Element#attr
	@example
		//Set
		//Before
		<ul id="maillist">
			<li id="folder">Read</li>
		</ul>
		
		//Do
		$Element("folder").data("count",123);
		$Element("folder").data("info",{
			"some1" : 1,
			"some2" : 2
		});
		
		//After
		<li id="folder" data-count="123" data-info="{\"some1\":1,\"some2\":2}">Read</li>
	@example
		//Get
		//Before
		<li id="folder" data-count="123" data-info="{\"some1\":1,\"some2\":2}">Read</li>
		
		//Do
		$Element("folder").data("count"); -> 123//Number
		$Element("folder").data("info"); -> {"some1":1, "some2":2} //Object
	@example
		//Delete
		//Before
		<li id="folder" data-count="123" data-info="{\"some1\":1,\"some2\":2}">Read</li>
		
		//Do
		$Element("folder").data("count",null);
		$Element("folder").data("info",null);
		
		//After
		<li id="folder">Read</li>
 */
nv.$Element.prototype.data = function(sKey, vValue) {
    var oType ={ 
        'g'  : ["sKey:String+"],
        's4var' : ["sKey:String+", "vValue:Variant"],
        's4obj' : ["oObj:Hash+"]
    };
    var nvKey = "_nv";
    function toCamelCase(name){
        return name.replace(/\-(.)/g,function(_,a){
            return a.toUpperCase();
        });
    }
    function toDash(name){
        return name.replace(/[A-Z]/g,function(a){
            return "-"+a.toLowerCase();
        });
    }
    if(document.body.dataset){
        nv.$Element.prototype.data = function(sKey, vValue) {
            var sToStr, oArgs = g_checkVarType(arguments, oType ,"$Element#data");
            var  isNull = nv.$Jindo.isNull;
            
            switch(oArgs+""){
                case "g":
                    sKey = toCamelCase(sKey);
                    var isMakeFromJindo = this._element.dataset[sKey+nvKey];
                    var sDateSet = this._element.dataset[sKey];
                    if(sDateSet){
                        if(isMakeFromJindo){
                            return window.JSON.parse(sDateSet);
                        }
                        return sDateSet;
                    }
                    return null;
                    // 'break' statement was intentionally omitted.
                case "s4var":
                    var oData;
                    if(isNull(vValue)){
                        sKey = toCamelCase(sKey);
                        delete this._element.dataset[sKey];
                        delete this._element.dataset[sKey+nvKey];
                        return this;
                    }else{
                        oData = {};
                        oData[sKey] = vValue;
                        sKey = oData;   
                    }
                    // 'break' statement was intentionally omitted.
                case "s4obj":
                    var sChange;
                    for(var i in sKey){
                        sChange = toCamelCase(i);
                        if(isNull(sKey[i])){
                            delete this._element.dataset[sChange];
                            delete this._element.dataset[sChange+nvKey];
                        }else{
                            sToStr = nv.$Json._oldToString(sKey[i]);
                            if(sToStr!=null){
                                this._element.dataset[sChange] = sToStr;
                                this._element.dataset[sChange+nvKey] = "nv";  
                            }
                        }
                    }
                    return this;
            }
        };
    }else{
        nv.$Element.prototype.data = function(sKey, vValue) {
            var sToStr, oArgs = g_checkVarType(arguments, oType ,"$Element#data");
            var  isNull = nv.$Jindo.isNull;
            switch(oArgs+""){
                case "g":
                    sKey = toDash(sKey);
                    var isMakeFromJindo = this._element.getAttribute("data-"+sKey+nvKey);
                    var sVal = this._element.getAttribute("data-"+sKey);
                    
                    if(isMakeFromJindo){
                        return (sVal!=null)? eval("("+sVal+")") : null;
                    }else{
                        return sVal;
                    }
                    // 'break' statement was intentionally omitted.
                case "s4var":
                    var oData;
                    if(isNull(vValue)){
                        sKey = toDash(sKey);
                        this._element.removeAttribute("data-"+sKey);
                        this._element.removeAttribute("data-"+sKey+nvKey);
                        return this;
                    }else{
                        oData = {};
                        oData[sKey] = vValue;
                        sKey = oData;   
                    }
                    // 'break' statement was intentionally omitted.
                case "s4obj":
                    var sChange;
                    for(var i in sKey){
                        sChange = toDash(i);
                        if(isNull(sKey[i])){
                            this._element.removeAttribute("data-"+sChange);
                            this._element.removeAttribute("data-"+sChange+nvKey);
                        }else{
                            sToStr = nv.$Json._oldToString(sKey[i]);
                            if(sToStr!=null){
                                this._element.setAttribute("data-"+sChange, sToStr);
                                this._element.setAttribute("data-"+sChange+nvKey, "nv");
                            }
                        }
                    }
                    return this;
            }
        };
    }
    
    return this.data.apply(this, nv._p_._toArray(arguments));
};
//-!nv.$Element.prototype.data end!-//

/**
 	@fileOverview $Json�� ������ �� �޼��带 ������ ����
	@name json.js
	@author NAVER Ajax Platform
 */

//-!nv.$Json start(nv.$Json._oldMakeJSON)!-//
/**
 	nv.$Json() ��ü�� JSON(JavaScript Object Notation)�� �ٷ�� ���� �پ��� ����� �����Ѵ�. �����ڿ� �Ķ���ͷ� ��ü�� ���ڿ��� �Է��Ѵ�. XML ������ ���ڿ��� nv.$Json() ��ü�� �����Ϸ��� fromXML() �޼��带 ����Ѵ�.
	
	@class nv.$Json
	@keyword json, ���̽�
 */
/**
 	nv.$Json() ��ü�� �����Ѵ�.
	
	@constructor
	@param {Varaint} sObject �پ��� Ÿ��
	@return {nv.$Json} �μ��� ���ڵ��� nv.$Json() ��ü.
	@see nv.$Json#fromXML
	@see http://www.json.org/json-ko.html json.org
	@example
		var oStr = $Json ('{ zoo: "myFirstZoo", tiger: 3, zebra: 2}');
		
		var d = {name : 'nhn', location: 'Bundang-gu'}
		var oObj = $Json (d);
 */
nv.$Json = function (sObject) {
	//-@@$Json-@@//
	var cl = arguments.callee;
	if (sObject instanceof cl) return sObject;
	
	if (!(this instanceof cl)){
		try {
			nv.$Jindo._maxWarn(arguments.length, 1,"$Json");
			return new cl(arguments.length?sObject:{});
		} catch(e) {
			if (e instanceof TypeError) { return null; }
			throw e;
		}
	}	
		
	g_checkVarType(arguments, {
		'4var' : ['oObject:Variant']
	},"$Json");
	this._object = sObject;
};
//-!nv.$Json end!-//

//-!nv.$Json._oldMakeJSON.hidden start!-//
nv.$Json._oldMakeJSON = function(sObject,sType){
	try {
		if(nv.$Jindo.isString(sObject)&&/^(?:\s*)[\{\[]/.test(sObject)){
			sObject = eval("("+sObject+")");
		}else{
			return sObject;
		}
	} catch(e) {
		throw new nv.$Error(nv.$Except.PARSE_ERROR,sType);
	}
	return sObject;
};
//-!nv.$Json._oldMakeJSON.hidden end!-//

//-!nv.$Json.fromXML start!-//
/**
  	fromXML() �޼���� XML ������ ���ڿ��� nv.$Json() ��ü�� ���ڵ��Ѵ�. XML ������ ���ڿ��� XML ��Ұ� �Ӽ��� �����ϰ� ���� ��� �ش� ����� ������ �ش��ϴ� ������ ���� ��ü�� ǥ���Ѵ�. �̶� ��Ұ� CDATA ���� ���� ��� $cdata �Ӽ����� ���� �����Ѵ�.
	
	@static
	@method fromXML
	@param {String+} sXML XML ������ ���ڿ�.
	@return {nv.$Json} nv.$Json() ��ü.
	@throws {nv.$Except.PARSE_ERROR} json��ü�� �Ľ��ϴٰ� �����߻��� ��.
	@example
		var j1 = $Json.fromXML('<data>only string</data>');
		
		// ��� :
		// {"data":"only string"}
		
		var j2 = $Json.fromXML('<data><id>Faqh%$</id><str attr="123">string value</str></data>');
		
		// ��� :
		// {"data":{"id":"Faqh%$","str":{"attr":"123","$cdata":"string value"}}}
  */
nv.$Json.fromXML = function(sXML) {
	//-@@$Json.fromXML-@@//
	var cache = nv.$Jindo;
	var oArgs = cache.checkVarType(arguments, {
		'4str' : ['sXML:String+']
	},"<static> $Json#fromXML");
	var o  = {};
	var re = /\s*<(\/?[\w:\-]+)((?:\s+[\w:\-]+\s*=\s*(?:"(?:\\"|[^"])*"|'(?:\\'|[^'])*'))*)\s*((?:\/>)|(?:><\/\1>|\s*))|\s*<!\[CDATA\[([\w\W]*?)\]\]>\s*|\s*>?([^<]*)/ig;
	var re2= /^[0-9]+(?:\.[0-9]+)?$/;
	var ec = {"&amp;":"&","&nbsp;":" ","&quot;":"\"","&lt;":"<","&gt;":">"};
	var fg = {tags:["/"],stack:[o]};
	var es = function(s){ 
		if (cache.isUndefined(s)) return "";
		return  s.replace(/&[a-z]+;/g, function(m){ return (cache.isString(ec[m]))?ec[m]:m; });
	};
	var at = function(s,c){s.replace(/([\w\:\-]+)\s*=\s*(?:"((?:\\"|[^"])*)"|'((?:\\'|[^'])*)')/g, function($0,$1,$2,$3){c[$1] = es(($2?$2.replace(/\\"/g,'"'):undefined)||($3?$3.replace(/\\'/g,"'"):undefined));}); };
	var em = function(o){
		for(var x in o){
			if (o.hasOwnProperty(x)) {
				if(Object.prototype[x])
					continue;
					return false;
			}
		}
		return true;
	};
	/*
	  $0 : ��ü
$1 : �±׸�
$2 : �Ӽ����ڿ�
$3 : �ݴ��±�
$4 : CDATA�ٵ�
$5 : �׳� �ٵ�
	 */

	var cb = function($0,$1,$2,$3,$4,$5) {
		var cur, cdata = "";
		var idx = fg.stack.length - 1;
		
		if (cache.isString($1)&& $1) {
			if ($1.substr(0,1) != "/") {
				var has_attr = (typeof $2 == "string" && $2);
				var closed   = (typeof $3 == "string" && $3);
				var newobj   = (!has_attr && closed)?"":{};

				cur = fg.stack[idx];
				
				if (cache.isUndefined(cur[$1])) {
					cur[$1] = newobj; 
					cur = fg.stack[idx+1] = cur[$1];
				} else if (cur[$1] instanceof Array) {
					var len = cur[$1].length;
					cur[$1][len] = newobj;
					cur = fg.stack[idx+1] = cur[$1][len];  
				} else {
					cur[$1] = [cur[$1], newobj];
					cur = fg.stack[idx+1] = cur[$1][1];
				}
				
				if (has_attr) at($2,cur);

				fg.tags[idx+1] = $1;

				if (closed) {
					fg.tags.length--;
					fg.stack.length--;
				}
			} else {
				fg.tags.length--;
				fg.stack.length--;
			}
		} else if (cache.isString($4) && $4) {
			cdata = $4;
		} else if (cache.isString($5) && $5) {
			cdata = es($5);
		}
		
		if (cdata.replace(/^\s+/g, "").length > 0) {
			var par = fg.stack[idx-1];
			var tag = fg.tags[idx];

			if (re2.test(cdata)) {
				cdata = parseFloat(cdata);
			}else if (cdata == "true"){
				cdata = true;
			}else if(cdata == "false"){
				cdata = false;
			}
			
			if(cache.isUndefined(par)) return;
			
			if (par[tag] instanceof Array) {
				var o = par[tag];
				if (cache.isHash(o[o.length-1]) && !em(o[o.length-1])) {
					o[o.length-1].$cdata = cdata;
					o[o.length-1].toString = function(){ return cdata; };
				} else {
					o[o.length-1] = cdata;
				}
			} else {
				if (cache.isHash(par[tag])&& !em(par[tag])) {
					par[tag].$cdata = cdata;
					par[tag].toString = function(){ return cdata; };
				} else {
					par[tag] = cdata;
				}
			}
		}
	};
	
	sXML = sXML.replace(/<(\?|\!-)[^>]*>/g, "");
	sXML.replace(re, cb);
	
	return nv.$Json(o);
};
//-!nv.$Json.fromXML end!-//

//-!nv.$Json.prototype.get start!-//
/**
 	get() �޼���� Ư�� ���(path)�� �ش��ϴ� nv.$Json() ��ü�� ���� ��ȯ�Ѵ�.

	@method get
	@param {String+} sPath ��θ� ������ ���ڿ�
	@return {Array} ������ ��ο� �ش��ϴ� ���� ���ҷ� ������ �迭.
	@throws {nv.$Except.PARSE_ERROR} json��ü�� �Ľ��ϴٰ� �����߻��� ��.
	@example
		var j = $Json.fromXML('<data><id>Faqh%$</id><str attr="123">string value</str></data>');
		var r = j.get ("/data/id");
		
		// ��� :
		// [Faqh%$]
 */
nv.$Json.prototype.get = function(sPath) {
	//-@@$Json.get-@@//
	var cache = nv.$Jindo;
	var oArgs = cache.checkVarType(arguments, {
		'4str' : ['sPath:String+']
	},"$Json#get");
	var o = nv.$Json._oldMakeJSON(this._object,"$Json#get");
	if(!(cache.isHash(o)||cache.isArray(o))){
		throw new nv.$Error(nv.$Except.JSON_MUST_HAVE_ARRAY_HASH,"$Json#get");
	}
	var p = sPath.split("/");
	var re = /^([\w:\-]+)\[([0-9]+)\]$/;
	var stack = [[o]], cur = stack[0];
	var len = p.length, c_len, idx, buf, j, e;
	
	for(var i=0; i < len; i++) {
		if (p[i] == "." || p[i] == "") continue;
		if (p[i] == "..") {
			stack.length--;
		} else {
			buf = [];
			idx = -1;
			c_len = cur.length;
			
			if (c_len == 0) return [];
			if (re.test(p[i])) idx = +RegExp.$2;
			
			for(j=0; j < c_len; j++) {
				e = cur[j][p[i]];
				if (cache.isUndefined(e)) continue;
				if (cache.isArray(e)) {
					if (idx > -1) {
						if (idx < e.length) buf[buf.length] = e[idx];
					} else {
						buf = buf.concat(e);
					}
				} else if (idx == -1) {
					buf[buf.length] = e;
				}
			}
			
			stack[stack.length] = buf;
		}
		
		cur = stack[stack.length-1];
	}

	return cur;
};
//-!nv.$Json.prototype.get end!-//

//-!nv.$Json.prototype.toString start(nv.$Json._oldToString)!-//
/**
 	toString() �޼���� nv.$Json() ��ü�� JSON ���ڿ� ���·� ��ȯ�Ѵ�.
	
	@method toString
	@return {String} JSON ���ڿ�.
	@see nv.$Json#toObject
	@see nv.$Json#toXML
	@see http://www.json.org/json-ko.html json.org
	@example
		var j = $Json({foo:1, bar: 31});
		document.write (j.toString());
		document.write (j);
		
		// ��� :
		// {"bar":31,"foo":1}{"bar":31,"foo":1} 
 */
nv.$Json.prototype.toString = function() {
	//-@@$Json.toString-@@//
    return nv.$Json._oldToString(this._object);

};
//-!nv.$Json.prototype.toString end!-//

//-!nv.$Json._oldToString.hidden start(nv.$H.prototype.ksort)!-//
nv.$Json._oldToString = function(oObj){
	var cache = nv.$Jindo;
	var func = {
		$ : function($) {
			if (cache.isNull($)||!cache.isString($)&&$==Infinity) return "null";
			if (cache.isFunction($)) return undefined;
			if (cache.isUndefined($)) return undefined;
			if (cache.isBoolean($)) return $?"true":"false";
			if (cache.isString($)) return this.s($);
			if (cache.isNumeric($)) return $;
			if (cache.isArray($)) return this.a($);
			if (cache.isHash($)) return this.o($);
			if (cache.isDate($)) return $+"";
			if (typeof $ == "object"||cache.isRegExp($)) return "{}";
			if (isNaN($)) return "null";
		},
		s : function(s) {
			var e = {'"':'\\"',"\\":"\\\\","\n":"\\n","\r":"\\r","\t":"\\t"};
            var c = function(m){ return (e[m] !== undefined)?e[m]:m; };
            return '"'+s.replace(/[\\"'\n\r\t]/g, c)+'"';
		},
		a : function(a) {
			var s = "[",c = "",n=a.length;
			for(var i=0; i < n; i++) {
				if (cache.isFunction(a[i])) continue;
				s += c+this.$(a[i]);
				if (!c) c = ",";
			}
			return s+"]";
		},
		o : function(o) {
			o = nv.$H(o).ksort().$value();
			var s = "{",c = "";
			for(var x in o) {
				if (o.hasOwnProperty(x)) {
					if (cache.isUndefined(o[x])||cache.isFunction(o[x])) continue;
					s += c+this.s(x)+":"+this.$(o[x]);
					if (!c) c = ",";
				}
			}
			return s+"}";
		}
	};

	return func.$(oObj);
};
//-!nv.$Json._oldToString.hidden end!-//

//-!nv.$Json.prototype.toXML start!-//
/**
 	toXML() �޼���� nv.$Json() ��ü�� XML ������ ���ڿ��� ��ȯ�Ѵ�.
	
	@method toXML
	@return {String} XML ������ ���ڿ�.
	@throws {nv.$Except.PARSE_ERROR} json��ü�� �Ľ��ϴٰ� �����߻��� ��.
	@see nv.$Json#toObject
	@see nv.$Json#toString
	@example
		var json = $Json({foo:1, bar: 31});
		json.toXML();
		
		// ��� :
		// <foo>1</foo><bar>31</bar>
 */
nv.$Json.prototype.toXML = function() {
	//-@@$Json.toXML-@@//
	var f = function($,tag) {
		var t = function(s,at) { return "<"+tag+(at||"")+">"+s+"</"+tag+">"; };
		
		switch (typeof $) {
			case 'undefined':
			case "null":
				return t("");
			case "number":
				return t($);
			case "string":
				if ($.indexOf("<") < 0){
					 return t($.replace(/&/g,"&amp;"));
				}else{
					return t("<![CDATA["+$+"]]>");
				}
				// 'break' statement was intentionally omitted.
			case "boolean":
				return t(String($));
			case "object":
				var ret = "";
				if ($ instanceof Array) {
					var len = $.length;
					for(var i=0; i < len; i++) { ret += f($[i],tag); }
				} else {
					var at = "";

					for(var x in $) {
						if ($.hasOwnProperty(x)) {
							if (x == "$cdata" || typeof $[x] == "function") continue;
							ret += f($[x], x);
						}
					}

					if (tag) ret = t(ret, at);
				}
				return ret;
		}
	};
	
	return f(nv.$Json._oldMakeJSON(this._object,"$Json#toXML"), "");
};
//-!nv.$Json.prototype.toXML end!-//

//-!nv.$Json.prototype.toObject start!-//
/**
 	toObject() �޼���� nv.$Json() ��ü�� ������ ������ ��ü�� ��ȯ�Ѵ�.
	
	@method toObject
	@return {Object} ���� ������ ��ü.
	@throws {nv.$Except.PARSE_ERROR} json��ü�� �Ľ��ϴٰ� �����߻��� ��.
	@see nv.$Json#toObject
	@see nv.$Json#toString
	@see nv.$Json#toXML
	@example
		var json = $Json({foo:1, bar: 31});
		json.toObject();
		
		// ��� :
		// {foo: 1, bar: 31}
 */
nv.$Json.prototype.toObject = function() {
	//-@@$Json.toObject-@@//
	//-@@$Json.$value-@@//
	return nv.$Json._oldMakeJSON(this._object,"$Json#toObject");
};
//-!nv.$Json.prototype.toObject end!-//

//-!nv.$Json.prototype.compare start(nv.$Json._oldToString,nv.$Json.prototype.toObject,nv.$Json.prototype.toString)!-//
/**
 	compare() �޼���� Json ��ü���� ���� ������ ���Ѵ�.
	
	@method compare
	@param {Varaint} oData ���� Json ���� ��ü.
	@return {Boolean} �� ���. ���� ������ true, �ٸ��� false�� ��ȯ�Ѵ�.
	@throws {nv.$Except.PARSE_ERROR} json��ü�� �Ľ��ϴٰ� �����߻��� ��.
	@since  1.4.4
	@example
		$Json({foo:1, bar: 31}).compare({foo:1, bar: 31});
		
		// ��� :
		// true
		
		$Json({foo:1, bar: 31}).compare({foo:1, bar: 1});
		
		// ��� :
		// false
 */
nv.$Json.prototype.compare = function(oObj){
	//-@@$Json.compare-@@//
	var cache = nv.$Jindo;
	var oArgs = cache.checkVarType(arguments, {
		'4obj' : ['oData:Hash+'],
		'4arr' : ['oData:Array+']
	},"$Json#compare");
	function compare(vSrc, vTar) {
		if (cache.isArray(vSrc)) {
			if (vSrc.length !== vTar.length) { return false; }
			for (var i = 0, nLen = vSrc.length; i < nLen; i++) {
				if (!arguments.callee(vSrc[i], vTar[i])) { return false; }
			}
			return true;
		} else if (cache.isRegExp(vSrc) || cache.isFunction(vSrc) || cache.isDate(vSrc)) {  // which compare using toString
			return String(vSrc) === String(vTar);
		} else if (typeof vSrc === "number" && isNaN(vSrc)) {
			return isNaN(vTar);
		} else if (cache.isHash(vSrc)) {
			var nLen = 0;
			for (var k in vSrc) {nLen++; }
			for (var k in vTar) { nLen--; }
			if (nLen !== 0) { return false; }

			for (var k in vSrc) {
				if (k in vTar === false || !arguments.callee(vSrc[k], vTar[k])) { return false; }
			}

			return true;
		}
		
		// which comare using ===
		return vSrc === vTar;
		
	}
	try{
		return compare(nv.$Json._oldMakeJSON(this._object,"$Json#compare"), oObj);
	}catch(e){
		return false;
	}
};
//-!nv.$Json.prototype.compare end!-//

//-!nv.$Json.prototype.$value start(nv.$Json.prototype.toObject)!-//
/**
 	$value() �޼���� toObject() �޼���� ���� ������ ������ ��ü�� ��ȯ�Ѵ�.
	
	@method $value
	@return {Object} ���� ������ ��ü.
	@see nv.$Json#toObject
 */
nv.$Json.prototype.$value = nv.$Json.prototype.toObject;
//-!nv.$Json.prototype.$value end!-//

/**
	@fileOverview nv.$Ajax() ��ü�� ������ �� �޼��带 ������ ����
	@name Ajax.js
	@author NAVER Ajax Platform
 */

//-!nv.$Ajax start(nv.$Json.prototype.toString,nv.$Fn.prototype.bind)!-//
/**
	nv.$Ajax() ��ü�� �پ��� ���� ȯ�濡�� Ajax ��û�� ������ ���� �����ϱ� ���� �޼��带 �����Ѵ�.
	
	@class nv.$Ajax
	@keyword ajax
 */
/**
	nv.$Ajax() ��ü�� ������ ������ ������ �񵿱� ���, �� Ajax ����� �����Ѵ�. nv.$Ajax() ��ü�� XHR ��ü(XMLHTTPRequest)�� ����� �⺻���� ��İ� �Բ� �ٸ� ������ ������ ����� ���� ���� ����� �����Ѵ�.
	
	@constructor
	@param {String+} sUrl Ajax ��û�� ���� ������ URL.
	@param {Hash+} oOption $Ajax()���� ����ϴ� �ݹ� �Լ�, ��� ��� ��� ���� �پ��� ������ �����Ѵ�.
		@param {String} [oOption.type="xhr"] Ajax ��û ���.
			@param {String} [oOption.type."xhr"] �������� ����� XMLHttpRequest ��ü�� �̿��Ͽ� Ajax ��û�� ó���Ѵ�. 
					<ul>
						<li>text, xml, json ������ ���� �����͸� ó���� �� �ִ�. </li>
						<li>��û ���� �� HTTP ���� �ڵ带 ���� ���� �ľ��� �����ϴ�.</li>
						<li>2.1.0 ���� �̻󿡼��� ũ�ν� �������� �ƴ� xhr�� ��� ����� "X-Requested-With" : "XMLHttpRequest"�� ������. </li>
						<li>��, ũ�ν� ������(Cross-Domain) ��Ȳ���� ����� �� ����.</li>
						<li>2.1.0 ���� �̻��� ����Ͽ��� ����. �ݵ�� ���������� �ʿ�. (�ڼ��� ������ <auidoc:see content="http://devcafe.nhncorp.com/ajaxui/board_5/574863">devcafe</auidoc:see>�� ����)</li>
					</ul>
			@param {String} oOption.type."iframe" iframe ��Ҹ� ���Ͻ÷� ����Ͽ� Ajax ��û�� ó���Ѵ�.
					<ul>
						<li>ũ�ν� ������ ��Ȳ���� ����� �� �ִ�.</li>
						<li>iframe ��û ����� ������ ���� �����Ѵ�.
							<ol class="decimal">
								<li>����(��û �ϴ� ��)�� ����(��û �޴� ��)�� ��� ���Ͻÿ� HTML ������ �����.</li>
								<li>���� ���Ͻÿ��� ���� ���Ͻ÷� �����͸� ��û�Ѵ�.</li>
								<li>���� ���Ͻð� ���� �����ο� XHR ������� �ٽ� Ajax ��û�Ѵ�.</li>
								<li>������ ���� ���� ���Ͻÿ��� ���� ���Ͻ÷� �����͸� �����Ѵ�.</li>
								<li>���� ���Ͻÿ��� ���������� �ݹ� �Լ�(onload)�� ȣ���Ͽ� ó���Ѵ�.</li>
							</ol>
						</li>
						<li>���� ���Ͻ� ���ϰ� ���� ���Ͻ� ������ ������ ���� �ۼ��� �� �ִ�.
							<ul>
								<li>���� ���Ͻ� ���� : ajax_remote_callback.html</li>
								<li>���� ���Ͻ� ���� : ajax_local_callback.html</li>
							</ul>
						</li>
						<li>iframe ��Ҹ� ����� ����� ���ͳ� �ͽ��÷η����� "����"�ϴ� ������ �̵����� �߻��� �� �ִ�. (��û�� 2ȸ)</li>
					</ul>
			@param {String} oOption.type."jsonp" JSON ���İ� &lt;script&gt; �±׸� ����Ͽ� ����Ͽ� Ajax ��û�� ó���Ѵ�.
					<ul>
						<li>ũ�ν� ������ ��Ȳ���� ����� �� �ִ�.</li>
						<li>jsonp ��û ����� ������ ���� �����Ѵ�.
							<ol class="decimal">
								<li>&lt;script&gt; �±׸� �������� �����Ѵ�. �̶� ��û�� ���� �������� src �Ӽ����� �Է��Ͽ� GET ������� ��û�� �����Ѵ�.</li>
								<li>��û �ÿ� �ݹ� �Լ��� �Ű� ������ �ѱ��, ���� ���������� ���޹��� �ݹ� �Լ������� �Ʒ��� ���� ������ ������.
									<ul>
										<li>function_name(...��� ��...)</li>
									</ul>
								</li>
								<li>������ �ݹ� �Լ�(onload)���� ó���ȴ�.</li>
							</ol>
						</li>
						<li>GET ��ĸ� �����ϹǷ�, ���� �������� ���̴� URL���� ����ϴ� ���̷� ���ѵȴ�.</li>
					</ul>
			@param {String} oOption.type."flash" �÷��� ��ü�� ����Ͽ� Ajax ��û�� ó���Ѵ�.
					<ul>
						<li>ũ�ν� ������ ��Ȳ���� ����� �� �ִ�.</li>
						<li>�� ����� ����� �� ���� ������ �� ��Ʈ ���͸��� crossdomain.xml ������ �����ؾ� �ϸ� �ش� ���Ͽ� ���� ������ �����Ǿ� �־�� �Ѵ�.</li>
						<li>��� ����� �÷��� ��ü�� ���Ͽ� �ְ� ������ Ajax ��û�� �õ��ϱ� ���� �ݵ�� �÷��� ��ü�� �ʱ�ȭ�ؾ� �Ѵ�.</li>
						<li>$Ajax.SWFRequest.write() �޼��带 ����Ͽ� �÷��� ��ü�� �ʱ�ȭ�ϸ� �ش� �޼���� &lt;body&gt; ��� �ȿ� �ۼ��Ѵ�.</li>
						<li>���� https���� https ������ ȣ���� ��� &lt;allow-access-from domain="*" secure="true" /&gt; ó�� secure�� true�� �����ؾ� �ϸ� �� �̿ܿ��� false�� �����Ѵ�.</li>
					</ul>
		@param {String} [oOption.method="post"] HTTP ��û ������� post, get, put, delete ����� �����Ѵ�.
			@param {String} [oOption.method."post"] post ������� http ��û�� �����Ѵ�.
			@param {String} oOption.method."get" get ������� http ��û�� �����Ѵ�. type �Ӽ��� "jsonp" ������� �����Ǹ� HTTP ��û ����� "get"���� �����ȴ�.
			@param {String} oOption.method."put" put ������� http ��û�� �����Ѵ�. (1.4.2 �������� ����).
			@param {String} oOption.method."delete" delete ������� http ��û�� �����Ѵ�. (1.4.2 �������� ����).
		@param {Number} [oOption.timeout=0] ��û Ÿ�� �ƿ� �ð�.  (���� ��)
				<ul>
					<li>�񵿱� ȣ���� ��쿡�� ��� �����ϴ�.</li>
					<li>Ÿ�� �ƿ� �ð� �ȿ� ��û�� �Ϸ���� ������ Ajax ��û�� �����Ѵ�.</li>
					<li>�����ϰų� �⺻��(0)�� ������ ��� Ÿ�� �ƿ��� �������� �ʴ´�. </li>
				</ul>
		@param {Boolean} [oOption.withCredentials=false] xhr���� ũ�ν� ������ ����� �� ��Ű ��뿩��. (���� ��)
				<ul>
					<li>����ϸ� �����ϴ�.</li>
					<li>true�� �����ϸ� ����������  "Access-Control-Allow-Credentials: true" ����� �����ؾ� �Ѵ�.</li>
				</ul>
		@param {Function} oOption.onload ��û�� �Ϸ�Ǹ� ������ �ݹ� �Լ�. �ݹ� �Լ��� �Ķ���ͷ� ���� ��ü�� <auidoc:see content="nv.$Ajax.Response"/> ��ü�� ���޵ȴ�.
		@param {Function} [oOption.onerror="onload �Ӽ��� ������ �ݹ� �Լ�"] ��û�� �����ϸ� ������ �ݹ� �Լ�. �����ϸ� ������ �߻��ص� onload �Ӽ��� ������ �ݹ� �Լ��� �����Ѵ�.
		@param {Function} [oOption.ontimeout=function(){}] Ÿ�� �ƿ��� �Ǿ��� �� ������ �ݹ� �Լ�. �����ϸ� Ÿ�� �ƿ� �߻��ص� �ƹ��� ó���� ���� �ʴ´�.
		@param {String} oOption.proxy ���� ���Ͻ� ������ ���. type �Ӽ��� "iframe"�� �� ���.
		@param {String} [oOption.jsonp_charset="utf-8"] ��û �� ����� &lt;script&gt; ���ڵ� ���. type �Ӽ��� "jsonp"�� �� ����Ѵ�. (0.4.2 �������� ����).
		@param {String} [oOption.callbackid="������ ID"] �ݹ� �Լ� �̸��� ����� ID.
				<ul>
					<li>type �Ӽ��� "jsonp"�� �� ����Ѵ�. (1.3.0 �������� ����)</li>
					<li>jsonp ��Ŀ��� Ajax ��û�� �� �ݹ� �Լ� �̸��� ������ ID ���� ���ٿ� ���� �ݹ� �Լ� �̸��� ������ �����Ѵ�. �̶� ������ ���� ID�� ����Ͽ� �ѱ�Ƿ� ��û URL�� �Ź� ���Ӱ� �����Ǿ� ĳ�� ������ �ƴ� ???���� ���� �����͸� ��û�ϰ� �ȴ�. ���� ID ���� �����ϸ� ������ ���̵� ������ �ݹ� �Լ� �̸��� �������� �����Ƿ� ĳ�� ������ ����Ͽ� �׿� ���� ��Ʈ���� ���̰��� �� �� ID�� �����Ͽ� ����� �� �ִ�.</li>
				</ul>
		@param {String} [oOption.callbackname="_callback"] �ݹ� �Լ� �̸�. type �Ӽ��� "jsonp"�� �� ����ϸ�, ������ ��û�� �ݹ� �Լ��� �̸��� ������ �� �ִ�. (1.3.8 �������� ����).
		@param {Boolean} [oOption.sendheader=true] ��û ����� �������� ����.<br>type �Ӽ��� "flash"�� �� ����ϸ�, �������� ���� ������ �����ϴ� crossdomain.xml�� allow-header�� �����Ǿ� ���� �ʴٸ� �ݵ�� false �� �����ؾ� �Ѵ�. (1.3.4 �������� ����).<br>
				<ul>
					<li>�÷��� 9������ allow-header�� false�� ��� get ������θ� ajax ����� �����ϴ�.</li>
					<li>�÷��� 10������ allow-header�� false�� ��� get,post �Ѵ� ajax ����� �ȵȴ�.</li>
					<li>allow-header�� �����Ǿ� ���� �ʴٸ� �ݵ�� false�� �����ؾ� �Ѵ�.</li>
				</ul>
		@param {Boolean} [oOption.async=true] �񵿱� ȣ�� ����. type �Ӽ��� "xhr"�� �� �� �Ӽ� ���� ��ȿ�ϴ�. (1.3.7 �������� ����).
		@param {Boolean} [oOption.decode=true] type �Ӽ��� "flash"�� �� ����ϸ�, ��û�� ������ �ȿ� utf-8 �� �ƴ� �ٸ� ���ڵ��� �Ǿ� ������ false �� �����Ѵ�. (1.4.0 �������� ����). 
		@param {Boolean} [oOption.postBody=false] Ajax ��û �� ������ ������ �����͸� Body ��ҿ� ������ ���� ����.<br>
				type �Ӽ��� "xhr"�̰� method�� "get"�� �ƴϾ�� ��ȿ�ϸ� REST ȯ�濡�� ���ȴ�. (1.4.2 �������� ����).
	@throws {nv.$Except.REQUIRE_AJAX} ����ϴ� Ÿ���� ajax�� ���� ���. 
	@throws {nv.$Except.CANNOT_USE_OPTION} ������� ���ϴ� �ɼ��� ����� ���.
	@remark nv.$Ajax() ��ü�� �⺻���� �ʱ�ȭ ����� ������ ����.
<pre class="code "><code class="prettyprint linenums">
	// ȣ���ϴ� URL�� ���� �������� URL�� �ٸ� ���, CORS ������� ȣ���Ѵ�. XHR2 ��ü �Ǵ� IE8,9�� XDomainRequest�� ����Ѵ�.
	var oAjax = new $Ajax('server.php', {
	    type : 'xhr',
	    method : 'get',     // GET ������� ���
	    onload : function(res){ // ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
	      $('list').innerHTML = res.text();
	    },
	    timeout : 3,      // 3�� �̳��� ��û�� �Ϸ���� ������ ontimeout ���� (���� �� 0)
	    ontimeout : function(){ // Ÿ�� �ƿ��� �߻��ϸ� ����� �ݹ� �Լ�, ���� �� Ÿ�� �ƿ��� �Ǹ� �ƹ� ó���� ���� ����
	      alert("Timeout!");
	    },
	    async : true      // �񵿱�� ȣ���ϴ� ���, �����ϸ� true
	});
	oAjax.request();
</code></pre><br>
	oOption ��ü�� ������Ƽ�� ������ ���� ������ ���� ǥ�� ����.<br>
		<h5>Ÿ�Կ� ���� �ɼ��� ��� ���� ����</h5>
		<table class="tbl_board">
			<caption class="hide">Ÿ�Կ� ���� �ɼ��� ��� ���� ����</caption>
			<thead>
				<th scope="col">�ɼ�</th>
				<th scope="col">xhr</th>
				<th scope="col">jsonp</th>
				<th scope="col">flash</th>
				<th scope="col">iframe</th>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">method(get, post, put, delete)</td>
					<td>O</td>
					<td>get</td>
					<td>get, post</td>
					<td>iframe</td>
				</tr>
				<tr>
					<td class="txt bold">onload</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
				</tr>
				<tr>
					<td class="txt bold">timeout</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">ontimeout</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">onerror</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">async</td>
					<td>O</td>
					<td>X</td>
					<td>X</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">postBody</td>
					<td>method�� post, put, delete�� ����</td>
					<td>X</td>
					<td>X</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">jsonp_charset</td>
					<td>X</td>
					<td>O</td>
					<td>X</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">callbackid</td>
					<td>X</td>
					<td>O</td>
					<td>X</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">callbackname</td>
					<td>X</td>
					<td>O</td>
					<td>X</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">setheader</td>
					<td>O</td>
					<td>X</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">decode</td>
					<td>X</td>
					<td>X</td>
					<td>O</td>
					<td>X</td>
				</tr>
				<tr>
					<td class="txt bold">proxy</td>
					<td>X</td>
					<td>X</td>
					<td>X</td>
					<td>O</td>
				</tr>
			</tbody>
		</table>
		<h5>Ÿ�Կ� ���� �޼����� ��� ���� ����</h5>
		<table class="tbl_board">
			<caption class="hide">Ÿ�Կ� ���� �޼����� ��� ���� ����</caption>
			<thead>
				<th scope="col">�޼���</th>
				<th scope="col">xhr</th>
				<th scope="col">jsonp</th>
				<th scope="col">flash</th>
				<th scope="col">iframe</th>
			</thead>
			<tbody>
				<tr>
					<td class="txt bold">abort</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
				</tr>
				<tr>
					<td class="txt bold">isIdle</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
				</tr>
				<tr>
					<td class="txt bold">option</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
				</tr>
				<tr>
					<td class="txt bold">request</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
					<td>O</td>
				</tr>
				<tr>
					<td class="txt bold">header</td>
					<td>O</td>
					<td>X</td>
					<td>O</td>
					<td>O</td>
				</tr>
			</tbody>
		</table>
	@see nv.$Ajax.Response
	@see http://dev.naver.com/projects/nv/wiki/cross%20domain%20ajax Cross Domain Ajax ����
	@example
		// 'Get List' ��ư Ŭ�� ��, �������� �����͸� �޾ƿ� ����Ʈ�� �����ϴ� ����
		// (1) ���� �������� ���� �������� ���� �����ο� �ִ� ��� - xhr
		
		// [client.html]
		<!DOCTYPE html>
		<html>
			<head>
				<title>Ajax Sample</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" language="javascript" src="lib/nv.all.js"></script>
				<script type="text/javascript" language="javascript">
					function getList() {
						var oAjax = new $Ajax('server.php', {
							type : 'xhr',
							method : 'get',			// GET ������� ���
							onload : function(res){	// ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
								$('list').innerHTML = res.text();
							},
							timeout : 3,			// 3�� �̳��� ��û�� �Ϸ���� ������ ontimeout ���� (���� �� 0)
							ontimeout : function(){	// Ÿ�� �ƿ��� �߻��ϸ� ����� �ݹ� �Լ�, ���� �� Ÿ�� �ƿ��� �Ǹ� �ƹ� ó���� ���� ����
								alert("Timeout!");
							},
							async : true			// �񵿱�� ȣ���ϴ� ���, �����ϸ� true
						});
						oAjax.request();
					}
				</script>
			</head>
			<body>
				<button onclick="getList(); return false;">Get List</button>
		
				<ul id="list">
		
				</ul>
			</body>
		</html>
		
		// [server.php]
		<?php
			echo "<li>ù��°</li><li>�ι�°</li><li>����°</li>";
		?>
	
	@example
		// 'Get List' ��ư Ŭ�� ��, �������� �����͸� �޾ƿ� ����Ʈ�� �����ϴ� ����
		// (1-1) ���� �������� ���� �������� �ٸ� �����ο� �ִ� ��� - xhr
		
		// [http://nv.com/client.html]
		<!DOCTYPE html>
		<html>
			<head>
				<title>Ajax Sample</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" language="javascript" src="lib/nv.all.js"></script>
				<script type="text/javascript" language="javascript">
					function getList() {
						var oAjax = new $Ajax('http://server.com/some/server.php', {
							type : 'xhr',
							method : 'get',			// GET ������� ���
							withCredentials : true, // ��Ű�� �����Ͽ� ����
							onload : function(res){	// ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
								$('list').innerHTML = res.text();
							}
						});
						oAjax.request();
					}
				</script>
			</head>
			<body>
				<button onclick="getList(); return false;">Get List</button>
		
				<ul id="list">
		
				</ul>
			</body>
		</html>
		
		// [server.php]
		 <?
		 	header("Access-Control-Allow-Origin: http://nv.com"); // ũ�ν����������� ȣ���� ������ ���� ���.
			header("Access-Control-Allow-Credentials: true"); // ��Ű�� ����� ���.
			
			echo "<li>ù��°</li><li>�ι�°</li><li>����°</li>";
		?>
	
	@example
		// 'Get List' ��ư Ŭ�� ��, �������� �����͸� �޾ƿ� ����Ʈ�� �����ϴ� ����
		// (2) ���� �������� ���� �������� ���� �����ο� �ִ� ��� - iframe
		
		// [http://local.com/some/client.html]
		<!DOCTYPE html>
		<html>
			<head>
				<title>Ajax Sample</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" language="javascript" src="lib/nv.all.js"></script>
				<script type="text/javascript" language="javascript">
					function getList() {
						var oAjax = new $Ajax('http://server.com/some/some.php', {
							type : 'iframe',
							method : 'get',			// GET ������� ���
													// POST�� �����ϸ� ���� ���Ͻ� ���Ͽ��� some.php �� ��û �ÿ� POST ������� ó��
							onload : function(res){	// ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
								$('list').innerHTML = res.text();
							},
							// ���� ���Ͻ� ������ ���.
							// �ݵ�� ��Ȯ�� ��θ� �����ؾ� �ϸ�, ���� �������� ��ζ�� ��� �ξ ��� ����
							// (�� ���� ���Ͻ� ������ �ݵ��  ���� ������ ������ ������ ��Ʈ �� �ξ�� ��)
							proxy : 'http://local.naver.com/some/ajax_local_callback.html'
						});
						oAjax.request();
					}
		
				</script>
			</head>
			<body>
				<button onclick="getList(); return false;">Get List</button>
		
				<ul id="list">
		
				</ul>
			</body>
		</html>
		
		// [http://server.com/some/some.php]
		<?php
			echo "<li>ù��°</li><li>�ι�°</li><li>����°</li>";
		?>
	
	@example
		// 'Get List' ��ư Ŭ�� ��, �������� �����͸� �޾ƿ� ����Ʈ�� �����ϴ� ����
		// (3) ���� �������� ���� �������� ���� �����ο� �ִ� ��� - jsonp
		
		// [http://local.com/some/client.html]
		<!DOCTYPE html>
		<html>
			<head>
				<title>Ajax Sample</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" language="javascript" src="lib/nv.all.js"></script>
				<script type="text/javascript" language="javascript">
					function getList(){
						var oAjax = new $Ajax('http://server.com/some/some.php', {
							type: 'jsonp',
							method: 'get',			// type �� jsonp �̸� get ���� �������� �ʾƵ� �ڵ����� get ���� ó���� (��������)
							jsonp_charset: 'utf-8',	// ��û �� ����� <script> ���ڵ� ��� (���� �� utf-8)
							onload: function(res){	// ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
								var response = res.json();
								var welList = $Element('list').empty();
		
								for (var i = 0, nLen = response.length; i < nLen; i++) {
									welList.append($("<li>" + response[i] + "</li>"));
								}
							},
							callbackid: '12345',				// �ݹ� �Լ� �̸��� ����� ���̵� �� (��������)
							callbackname: 'ajax_callback_fn'	// �������� ����� �ݹ� �Լ��̸��� ������ �Ű� ���� �̸� (���� �� '_callback')
						});
						oAjax.request();
					}
				</script>
			</head>
			<body>
				<button onclick="getList(); return false;">Get List</button>
		
				<ul id="list">
		
				</ul>
			</body>
		</html>
		
		// [http://server.com/some/some.php]
		<?php
			$callbackName = $_GET['ajax_callback_fn'];
			echo $callbackName."(['ù��°','�ι�°','����°'])";
		?>
	
	@example
		// 'Get List' ��ư Ŭ�� ��, �������� �����͸� �޾ƿ� ����Ʈ�� �����ϴ� ����
		// (4) ���� �������� ���� �������� ���� �����ο� �ִ� ��� - flash
		
		// [http://local.com/some/client.html]
		<!DOCTYPE html>
		<html>
			<head>
				<title>Ajax Sample</title>
				<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" language="javascript" src="lib/nv.all.js"></script>
				<script type="text/javascript" language="javascript">
					function getList(){
						var oAjax = new $Ajax('http://server.com/some/some.php', {
							type : 'flash',
							method : 'get',			// GET ������� ���
							sendheader : false,		// ��û ����� �������� ����. (���� �� true)
							decode : true,			// ��û�� ������ �ȿ� utf-8 �� �ƴ� �ٸ� ���ڵ��� �Ǿ� ������ false. (���� �� true)
							onload : function(res){	// ��û�� �Ϸ�Ǹ� ����� �ݹ� �Լ�
								$('list').innerHTML = res.text();
							},
						});
						oAjax.request();
					}
				</script>
			</head>
			<body>
				<script type="text/javascript">
					$Ajax.SWFRequest.write("swf/ajax.swf");	// Ajax ȣ���� �ϱ� ���� �ݵ�� �÷��� ��ü�� �ʱ�ȭ
				</script>
				<button onclick="getList(); return false;">Get List</button>
		
				<ul id="list">
		
				</ul>
			</body>
		</html>
		
		// [http://server.com/some/some.php]
		<?php
			echo "<li>ù��°</li><li>�ι�°</li><li>����°</li>";
		?>
 */
nv.$Ajax = function (url, option) {
	var cl = arguments.callee;

	if (!(this instanceof cl)){
		try {
			nv.$Jindo._maxWarn(arguments.length, 2,"$Ajax");
			return new cl(url, option||{});
		} catch(e) {
			if (e instanceof TypeError) { return null; }
			throw e;
		}
	}	

	var ___ajax = nv.$Ajax, ___error = nv.$Error, ___except = nv.$Except;
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'sURL:String+' ],
		'4obj' : [ 'sURL:String+', 'oOption:Hash+' ]
	},"$Ajax");
		
	if(oArgs+"" == "for_string"){
		oArgs.oOption = {};
	}
	
	function _getXHR(sUrl) {
        var xhr = window.XMLHttpRequest && new XMLHttpRequest();

        if(this._checkCORSUrl(this._url)) {
            if(xhr && "withCredentials" in xhr) {
                return xhr;

            // for IE8 and 9 CORS call can be used right through 'XDomainRequest' object - http://msdn.microsoft.com/en-us/library/ie/cc288060(v=vs.85).aspx
            // Limitations - http://blogs.msdn.com/b/ieinternals/archive/2010/05/13/xdomainrequest-restrictions-limitations-and-workarounds.aspx
            } else if(window.XDomainRequest) {
                this._bXDomainRequest = true;
                return new XDomainRequest();
            }
        } else {
            if(xhr) {
                return xhr;
            } else if(window.ActiveXObject) {
                try {
                    return new ActiveXObject('MSXML2.XMLHTTP');
                }catch(e) {
                    return new ActiveXObject('Microsoft.XMLHTTP');
                }
            }
        }

        return null;
	}

	var loc = location.toString();
	var domain = '';
	try { domain = loc.match(/^https?:\/\/([a-z0-9_\-\.]+)/i)[1]; } catch(e) {}
	
	this._status = 0;
	this._url = oArgs.sURL;
	this._headers  = {};
	this._options = {
		type   :"xhr",
		method :"post",
		proxy  :"",
		timeout:0,
		onload :function(req){},
		onerror :null,
		ontimeout:function(req){},
		jsonp_charset : "utf-8",
		callbackid : "",
		callbackname : "",
		sendheader : true,
		async : true,
		decode :true,
		postBody :false,
        withCredentials:false
	};

	this._options = ___ajax._setProperties(oArgs.oOption,this);
	___ajax._validationOption(this._options,"$Ajax");
	
	/*
	 �׽�Ʈ�� ���� �켱 ���밡���� ���� ��ü�� �����ϸ� ����
	 */
	if(___ajax.CONFIG){
		this.option(___ajax.CONFIG);
	}

	var _opt = this._options;
	
	_opt.type   = _opt.type.toLowerCase();
	_opt.method = _opt.method.toLowerCase();

	if (window["__"+nv._p_.nvName+"_callback"] === undefined) {
		window["__"+nv._p_.nvName+"_callback"] = [];
		// JINDOSUS-1412
		window["__"+nv._p_.nvName+"2_callback"] = [];
	}

	var t = this;
	switch (_opt.type) {
		case "put":
		case "delete":
		case "get":
		case "post":
			_opt.method = _opt.type;
            // 'break' statement was intentionally omitted.
		case "xhr":
			//-@@$Ajax.xhr-@@//
			this._request = _getXHR.call(this);
        	this._checkCORS(this._url,_opt.type,"");
			break;
		case "flash":
			//-@@$Ajax.flash-@@//
			if(!___ajax.SWFRequest) throw new ___error(nv._p_.nvName+'.$Ajax.SWFRequest'+___except.REQUIRE_AJAX, "$Ajax");
			
			this._request = new ___ajax.SWFRequest( function(name,value){return t.option.apply(t, arguments);} );
			break;
		case "jsonp":
			//-@@$Ajax.jsonp-@@//
			if(!___ajax.JSONPRequest) throw new ___error(nv._p_.nvName+'.$Ajax.JSONPRequest'+___except.REQUIRE_AJAX, "$Ajax");
			this._request = new ___ajax.JSONPRequest( function(name,value){return t.option.apply(t, arguments);} );
			break;
		case "iframe":
			//-@@$Ajax.iframe-@@//
			if(!___ajax.FrameRequest) throw new ___error(nv._p_.nvName+'.$Ajax.FrameRequest'+___except.REQUIRE_AJAX, "$Ajax");
			this._request = new ___ajax.FrameRequest( function(name,value){return t.option.apply(t, arguments);} );
	}
};

nv.$Ajax.prototype._checkCORSUrl = function (sUrl) {
    return /^http/.test(sUrl) && !new RegExp("^https?://"+ window.location.host, "i").test(sUrl);
};

nv.$Ajax.prototype._checkCORS = function(sUrl,sType,sMethod){
	this._bCORS = false;

	if(this._checkCORSUrl(sUrl) && sType === "xhr") {
		if(this._request && (this._bXDomainRequest || "withCredentials" in this._request)) {
		    this._bCORS = true;
		} else {
			throw new nv.$Error(nv.$Except.NOT_SUPPORT_CORS, "$Ajax"+sMethod);
		}
	}
};

nv.$Ajax._setProperties = function (option, context){
	option = option||{};
	var type;
	if((option.type=="put"||option.type=="delete"||option.type=="get"||option.type=="post")&&!option.method){
	    option.method = option.type;
	    type = option.type = "xhr";
	}
	
	type = option.type = (option.type||"xhr");
	option.onload = nv.$Fn(option.onload||function(){},context).bind();
	option.method = option.method ||"post";
	if(type != "iframe"){
		option.timeout = option.timeout||0;
		option.ontimeout = nv.$Fn(option.ontimeout||function(){},context).bind();
		option.onerror = nv.$Fn(option.onerror||function(){},context).bind();
	}
	if(type == "xhr"){
		option.async = option.async === undefined?true:option.async;
		option.postBody = option.postBody === undefined?false:option.postBody;
        option.withCredentials = option.withCredentials === undefined?false:option.withCredentials;
	}else if(type == "jsonp"){
		option.method = "get";
		option.jsonp_charset = option.jsonp_charset ||"utf-8";
		option.callbackid = option.callbackid ||"";
		option.callbackname = option.callbackname ||"";
	}else if(type == "flash"){
		option.sendheader =  option.sendheader === undefined ? true : option.sendheader;
		option.decode =  option.decode === undefined ? true : option.decode;
	}else if(type == "iframe"){
		option.proxy = option.proxy||"";
	}
	return option;
};

nv.$Ajax._validationOption = function(oOption,sMethod){
	var ___except = nv.$Except;
	var sType = oOption.type;
	if(sType === "jsonp"){
		if(oOption["method"] !== "get") nv.$Jindo._warn(___except.CANNOT_USE_OPTION+"\n\t"+sMethod+"-method="+oOption["method"]);
	}else if(sType === "flash"){
		if(!(oOption["method"] === "get" || oOption["method"] === "post")) nv.$Jindo._warn(___except.CANNOT_USE_OPTION+"\n\t"+sMethod+"-method="+oOption["method"]);
	}
	
	if(oOption["postBody"]){
		if(!(sType === "xhr" && (oOption["method"]!=="get"))){
			nv.$Jindo._warn(___except.CANNOT_USE_OPTION+"\n\t"+oOption["method"]+"-postBody="+oOption["postBody"]);
		}
	}
	
	var oTypeProperty = {
			"xhr": "onload|timeout|ontimeout|onerror|async|method|postBody|type|withCredentials",
			"jsonp": "onload|timeout|ontimeout|onerror|jsonp_charset|callbackid|callbackname|method|type",
			"flash": "onload|timeout|ontimeout|onerror|sendheader|decode|method|type",
			"iframe": "onload|proxy|method|type"
	}, aName = [], i = 0;

    for(var x in oOption) { aName[i++] = x; }
	var sProperty = oTypeProperty[sType] || "";
	
	for(var i = 0 ,l = aName.length; i < l ; i++){
		if(sProperty.indexOf(aName[i]) == -1) nv.$Jindo._warn(___except.CANNOT_USE_OPTION+"\n\t"+sType+"-"+aName[i]);
	}
};
/**
 * @ignore
 */
nv.$Ajax.prototype._onload = (function(isIE) {
	var ___ajax = nv.$Ajax;
	var cache = nv.$Jindo;

	if(isIE){
		return function() {
			var status = this._request.status;
			var bSuccess = this._request.readyState == 4 &&  (status == 200||status == 0) || (this._bXDomainRequest && !!this._request.responseText);
			var oResult;
			if (this._request.readyState == 4 || this._bXDomainRequest) {
				try {
						if ((!bSuccess) && cache.isFunction(this._options.onerror)){
							this._options.onerror(new ___ajax.Response(this._request));
						}else{
							if(!this._is_abort){
								oResult = this._options.onload(new ___ajax.Response(this._request));	
							}
						} 
				}catch(e){
					throw e;
				}finally{
					if(cache.isFunction(this._oncompleted)){
						this._oncompleted(bSuccess, oResult);
					}
					if (this._options.type == "xhr" ){
						this.abort();
						try { delete this._request.onload; } catch(e) { this._request.onload =undefined;} 
					}
					this._request.onreadystatechange && delete this._request.onreadystatechange;
					
				}
			}
		};
	}else{
		return function() {
			var status = this._request.status;
			var bSuccess = this._request.readyState == 4 &&  (status == 200||status == 0);
			var oResult;
			if (this._request.readyState == 4) {
				try {
				  		
						if ((!bSuccess) && cache.isFunction(this._options.onerror)){
							this._options.onerror(new ___ajax.Response(this._request));
						}else{
							oResult = this._options.onload(new ___ajax.Response(this._request));
						} 
				}catch(e){
					throw e;
				}finally{
					this._status--;
					if(cache.isFunction(this._oncompleted)){
						this._oncompleted(bSuccess, oResult);
					} 
				}
			}
		};
	}
})(nv._p_._JINDO_IS_IE);


/**
	request() �޼���� Ajax ��û�� ������ �����Ѵ�. ��û�� ����� �Ķ���ʹ� nv.$Ajax() ��ü �����ڿ��� �����ϰų� option() �޼��带 ����Ͽ� ������ �� �ִ�. 
	��û Ÿ��(type)�� "flash"�� �� �޼��带 �����ϱ� ���� body ��ҿ��� <auidoc:see content="nv.$Ajax.SWFRequest#write"/>() �޼��带 �ݵ�� �����ؾ� �Ѵ�.
	
	@method request
	@syntax oData
	@syntax oData2
	@param {String+} [oData] ������ ������ ������. (postbody�� true, type�� xhr, method�� get�� �ƴ� ��츸 ��밡��)
	@param {Hash+} oData2 ������ ������ ������.
	@return {this} �ν��Ͻ� �ڽ�
	@see nv.$Ajax#option
	@see nv.$Ajax.SWFRequest#write
	@example
		var ajax = $Ajax("http://www.remote.com", {
		   onload : function(res) {
		      // onload �ڵ鷯
		   }
		});
		
		ajax.request( {key1:"value1", key2:"value2"} );	// ������ ������ �����͸� �Ű������� �ѱ��.
		ajax.request( );
	
	@example
		var ajax2 = $Ajax("http://www.remote.com", {
		   type : "xhr",
		   method : "post",
		   postBody : true
		});
		
		ajax2.request({key1:"value1", key2:"value2"});
		ajax2.request("{key1:\"value1\", key2:\"value2\"}");
 */
nv.$Ajax.prototype.request = function(oData) {
	var cache = nv.$Jindo;
	var oArgs = cache.checkVarType(arguments, {
		'4voi' : [ ],
		'4obj' : [ cache._F('oData:Hash+') ],
		'4str' : [ 'sData:String+' ]
	},"$Ajax#request");
	
	this._status++;
	var t   = this;
	var req = this._request;
	var opt = this._options;
	var v,a = [], data = "";
	var _timer = null;
	var url = this._url;
	this._is_abort = false;
	var sUpType = opt.type.toUpperCase();
	var sUpMethod = opt.method.toUpperCase();
	if (opt.postBody && sUpType == "XHR" && sUpMethod != "GET") {
		if(oArgs+"" == "4str"){
			data = oArgs.sData;
		}else if(oArgs+"" == "4obj"){
			data = nv.$Json(oArgs.oData).toString();	
		}else{
			data = null;
		}
	}else{
		switch(oArgs+""){
			case "4voi" : 
				data = null;
				break;
			case "4obj":
				var oData = oArgs.oData;
				for(var k in oData) {
					if(oData.hasOwnProperty(k)){
						v = oData[k];
						if (cache.isFunction(v)) v = v();
						
						if (cache.isArray(v) || (nv.$A && v instanceof nv.$A)) {
							if(v instanceof nv.$A) v = v._array;
							
							for(var i=0; i < v.length; i++) {
								a[a.length] = k+"="+encodeURIComponent(v[i]);
							}
						} else {
							a[a.length] = k+"="+encodeURIComponent(v);
						}
					}
				}
				data = a.join("&");
		}
	}
	
	/*
	 XHR GET ��� ��û�� ��� URL�� �Ķ���� �߰�
	 */
	if(data && sUpType=="XHR" && sUpMethod=="GET"){
		if(url.indexOf('?')==-1){
			url += "?";
		} else {
			url += "&";			
		}
		url += data;
		data = null;
	}

	if(sUpType=="XHR"){
		req.open(sUpMethod, url, !!opt.async);
	}else{
		req.open(sUpMethod, url);
	}

	if(opt.withCredentials){
		req.withCredentials = true;
	}

	if(sUpType=="XHR"&&sUpMethod=="POST"&&req.setRequestHeader){
		/*
		 xhr�� ��� IE������ GET���� ���� �� ���������� ��ü cache�Ͽ� cache�� �ȵǰ� ����.
		 */
		req.setRequestHeader("If-Modified-Since", "Thu, 1 Jan 1970 00:00:00 GMT");
	} 
	if ((sUpType=="XHR"||sUpType=="IFRAME"||(sUpType=="FLASH"&&opt.sendheader)) && req.setRequestHeader) {
		if(!this._headers["Content-Type"]){
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
		}
		req.setRequestHeader("charset", "utf-8");
		if(!this._bCORS&&!this._headers["X-Requested-With"]){
			req.setRequestHeader("X-Requested-With", "XMLHttpRequest");
		}
		for (var x in this._headers) {
			if(this._headers.hasOwnProperty(x)){
				if (typeof this._headers[x] == "function") 
					continue;
				req.setRequestHeader(x, String(this._headers[x]));
			}
		}
	}
	if(req.addEventListener&&!nv._p_._JINDO_IS_OP&&!nv._p_._JINDO_IS_IE){
		/*
		  * opera 10.60���� XMLHttpRequest�� addEventListener�� �߰��Ǿ����� ���������� �������� �ʾ� opera�� ������ dom1������� ������.
 * IE9������ opera�� ���� ������ ����.
		 */
		if(this._loadFunc){ req.removeEventListener("load", this._loadFunc, false); }
		this._loadFunc = function(rq){ 
			clearTimeout(_timer);
			_timer = undefined; 
			t._onload(rq); 
		};
		req.addEventListener("load", this._loadFunc, false);
	}else{
		if (req.onload !== undefined) {
			req.onload = function(rq){
				if((req.readyState == 4 || t._bXDomainRequest) && !t._is_abort){
					clearTimeout(_timer); 
					_timer = undefined;
					t._onload(rq);
				}
			};
		} else {
            /*
             * IE6������ onreadystatechange�� ���������� ����Ǿ� timeout�̺�Ʈ�� �߻��ȵ�.
 * �׷��� interval�� üũ�Ͽ� timeout�̺�Ʈ�� ���������� �߻��ǵ��� ����. �񵿱� ����϶���
             */
            var iePattern = nv._p_._j_ag.match(/(?:MSIE) ([0-9.]+)/);
			if(iePattern&&iePattern[1]==6&&opt.async){
				var onreadystatechange = function(rq){
					if(req.readyState == 4 && !t._is_abort){
						if(_timer){
							clearTimeout(_timer);
							_timer = undefined;
						}
						t._onload(rq);
						clearInterval(t._interval);
						t._interval = undefined;
					}
				};
				this._interval = setInterval(onreadystatechange,300);

			}else{
				req.onreadystatechange = function(rq){
					if(req.readyState == 4){
						clearTimeout(_timer); 
						_timer = undefined;
						t._onload(rq);
					}
				};
			}
		}
	}

	if (opt.timeout > 0) {
		if(this._timer) clearTimeout(this._timer);
		
		_timer = setTimeout(function(){
			t._is_abort = true;
			if(t._interval){
				clearInterval(t._interval);
				t._interval = undefined;
			}
			try { req.abort(); } catch(e){}

			opt.ontimeout(req);	
			if(cache.isFunction(t._oncompleted)) t._oncompleted(false);
		}, opt.timeout * 1000 );

		this._timer = _timer;
	}
	/*
	 * test�� �ϱ� ���� url
	 */
	this._test_url = url;
	req.send(data);

	return this;
};

/**
	isIdle() �޼���� nv.$Ajax() ��ü�� ���� ��û ��� �������� Ȯ���Ѵ�.
	
	@method isIdle
	@return {Boolean} ���� ��� ���̸� true ��, �׷��� ������ false�� �����Ѵ�.
	@since 1.3.5
	@example
		var ajax = $Ajax("http://www.remote.com",{
		     onload : function(res){
		         // onload �ڵ鷯
		     }
		});
		
		if(ajax.isIdle()) ajax.request();
 */
nv.$Ajax.prototype.isIdle = function(){
	return this._status==0;
};

/**
	abort() �޼���� ������ ������ Ajax ��û�� ����Ѵ�. Ajax ��û�� ���� �ð��� ��ų� ������ Ajax ��û�� ����� ��� ����Ѵ�.
	
	@method abort
	@remark type�� jsonp�� ��� abort�� �ص� ��û�� ������ �ʴ´�.
	@return {this} ������ ����� �ν��Ͻ� �ڽ�
	@example
		var ajax = $Ajax("http://www.remote.com", {
			timeout : 3,
			ontimeout : function() {
				stopRequest();
			}
			onload : function(res) {
				// onload �ڵ鷯
			}
		}).request( {key1:"value1", key2:"value2"} );
		
		function stopRequest() {
		    ajax.abort();
		}
 */
nv.$Ajax.prototype.abort = function() {
	try {
		if(this._interval) clearInterval(this._interval);
		if(this._timer) clearTimeout(this._timer);
		this._interval = undefined;
		this._timer = undefined;
		this._is_abort = true;
		this._request.abort();
	}finally{
		this._status--;
	}

	return this;
};

/**
	url()�޼���� url�� ��ȯ�Ѵ�.
	
	@method url
	@return {String} URL�� ��.
	@since 2.0.0
 */
/**
	url()�޼���� url�� �����Ѵ�.
	
	@method url
	@param {String+} url
	@return {this} �ν��Ͻ� �ڽ�
	@since 2.0.0
 */
nv.$Ajax.prototype.url = function(sURL){
	var oArgs = g_checkVarType(arguments, {
		'g' : [ ],
		's' : [ 'sURL:String+' ]
	},"$Ajax#url");
	
	switch(oArgs+"") {
		case 'g':
	    	return this._url;
		case 's':
		    this._checkCORS(oArgs.sURL,this._options.type,"#url");
	    	this._url = oArgs.sURL;
			return this;
			
	}
};
/**
	option() �޼���� nv.$Ajax() ��ü�� �ɼ� ��ü(oOption) �Ӽ��� ���ǵ� Ajax ��û �ɼǿ� ���� ������ �����´�.
	
	@method option
	@param {String+} sName �ɼ� ��ü�� �Ӽ� �̸�
	@return {Variant} �ش� �ɼǿ� �ش��ϴ� ��.
	@throws {nv.$Except.CANNOT_USE_OPTION} �ش� Ÿ�Կ� ������ �ɼ��� �ƴ� ���.
 */
/**
	option() �޼���� nv.$Ajax() ��ü�� �ɼ� ��ü(oOption) �Ӽ��� ���ǵ� Ajax ��û �ɼǿ� ���� ������ �����Ѵ�. Ajax ��û �ɼ��� �����Ϸ��� �̸��� ����, Ȥ�� �̸��� ���� ���ҷ� ������ �ϳ��� ��ü�� �Ķ���ͷ� �Է��Ѵ�. �̸��� ���� ���ҷ� ������ ��ü�� �Է��ϸ� �ϳ� �̻��� ������ �� ���� ������ �� �ִ�.
	
	@method option
	@syntax sName, vValue
	@syntax oOption
	@param {String+} sName �ɼ� ��ü�� �Ӽ� �̸�
	@param {Variant} vValue ���� ������ �ɼ� �Ӽ��� ��.
	@param {Hash+} oOption �Ӽ� ���� ���ǵ� ��ü.
	@return {this} �ν��Ͻ� �ڽ�
	@throws {nv.$Except.CANNOT_USE_OPTION} �ش� Ÿ�Կ� ������ �ɼ��� �ƴ� ���.
	@example
		var ajax = $Ajax("http://www.remote.com", {
			type : "xhr",
			method : "get",
			onload : function(res) {
				// onload �ڵ鷯
			}
		});
		
		var request_type = ajax.option("type");					// type �� xhr �� �����Ѵ�.
		ajax.option("method", "post");							// method �� post �� �����Ѵ�.
		ajax.option( { timeout : 0, onload : handler_func } );	// timeout �� ����, onload �� handler_func �� �����Ѵ�.
 */
nv.$Ajax.prototype.option = function(name, value) {
	var oArgs = g_checkVarType(arguments, {
		's4var' : [ 'sKey:String+', 'vValue:Variant' ],
		's4obj' : [ 'oOption:Hash+'],
		'g' : [ 'sKey:String+']
	},"$Ajax#option");
	
	switch(oArgs+"") {
		case "s4var":
			oArgs.oOption = {};
			oArgs.oOption[oArgs.sKey] = oArgs.vValue;
			// 'break' statement was intentionally omitted.
		case "s4obj":
			var oOption = oArgs.oOption;
			try {
				for (var x in oOption) {
					if (oOption.hasOwnProperty(x)){
						if(x==="onload"||x==="ontimeout"||x==="onerror"){
							this._options[x] = nv.$Fn(oOption[x],this).bind(); 
						}else{
							this._options[x] = oOption[x];	
						}		
					}
				}
			}catch (e) {}
			break;
		case 'g':
			return this._options[oArgs.sKey];
			
	}
	this._checkCORS(this._url,this._options.type,"#option");
	nv.$Ajax._validationOption(this._options,"$Ajax#option");

	return this;
};

/**
	header() �޼���� Ajax ��û���� ����� HTTP ��û ����� �����´�. ������� Ư�� �Ӽ� ���� ���������� �Ӽ��� �̸��� �Ķ���ͷ� �Է��Ѵ�.
	
	@method header
	@param {String+} vName ��� �̸�
	@return {String} ���ڿ��� ��ȯ�Ѵ�.
	@example
		var customheader = ajax.header("myHeader"); 		// HTTP ��û ������� myHeader �� ��
 */
/**
	header() �޼���� Ajax ��û���� ����� HTTP ��û ����� �����Ѵ�. ����� �����Ϸ��� ����� �̸��� ���� ���� �Ķ���ͷ� �Է��ϰų� ����� �̸��� ���� ���ҷ� ������ ��ü�� �Ķ���ͷ� �Է��Ѵ�. ��ü�� �Ķ���ͷ� �Է��ϸ� �ϳ� �̻��� ����� �� ���� ������ �� �ִ�.<br>
	(* IE8/9���� XDomainRequest ��ü�� ����� CORS ȣ�⿡���� ����� �� ����. XDomainRequest�� ����� ������ �� �ִ� �޼��尡 �������� �ʴ´�.)
	
	@method header
	@syntax sName, sValue
	@syntax oHeader
	@param {String+} sName ��� �̸�
	@param {String+} sValue ������ ��� ��.
	@param {Hash+} oHeader �ϳ� �̻��� ��� ���� ���ǵ� ��ü
	@return {this} ��� ���� ������ �ν��Ͻ� �ڽ�
	@throws {nv.$Except.CANNOT_USE_OPTION} jsonp Ÿ���� ��� header�޼��带 ���� �� ��.
	@example
		ajax.header( "myHeader", "someValue" );				// HTTP ��û ����� myHeader �� someValue �� �����Ѵ�.
		ajax.header( { anotherHeader : "someValue2" } );	// HTTP ��û ����� anotherHeader �� someValue2 �� �����Ѵ�.
 */
nv.$Ajax.prototype.header = function(name, value) {
	if(this._options["type"]==="jsonp" || this._bXDomainRequest){nv.$Jindo._warn(nv.$Except.CANNOT_USE_HEADER);}
	
	var oArgs = g_checkVarType(arguments, {
		's4str' : [ 'sKey:String+', 'sValue:String+' ],
		's4obj' : [ 'oOption:Hash+' ],
		'g' : [ 'sKey:String+' ]
	},"$Ajax#option");
	
	switch(oArgs+"") {
		case 's4str':
			this._headers[oArgs.sKey] = oArgs.sValue;
			break;
		case 's4obj':
			var oOption = oArgs.oOption;
			try {
				for (var x in oOption) {
					if (oOption.hasOwnProperty(x)) 
						this._headers[x] = oOption[x];
				}
			} catch(e) {}
			break;
		case 'g':
			return this._headers[oArgs.sKey];
			
	}

	return this;
};

/**
	nv.$Ajax.Response() ��ü�� �����Ѵ�. nv.$Ajax.Response() ��ü�� nv.$Ajax() ��ü���� request() �޼����� ��û ó�� �Ϸ��� �� �����ȴ�. nv.$Ajax() ��ü�� ������ �� onload �Ӽ��� ������ �ݹ� �Լ��� �Ķ���ͷ� nv.$Ajax.Response() ��ü�� ���޵ȴ�.

	@class nv.$Ajax.Response
	@keyword ajaxresponse, ajax, response
 */
/**
	Ajax ���� ��ü�� �����Ͽ� ���� �����͸� �������ų� Ȱ���ϴµ� ������ ����� �����Ѵ�.
	
	@constructor
	@param {Hash+} oReq ��û ��ü
	@see nv.$Ajax
 */
nv.$Ajax.Response  = function(req) {
	this._response = req;
	this._regSheild = /^for\(;;\);/;
};

/**
{{response_desc}}
 */
/**
/**
	xml() �޼���� ������ XML ��ü�� ��ȯ�Ѵ�. XHR�� responseXML �Ӽ��� �����ϴ�.
	
	@method xml
	@return {Object} ���� XML ��ü. 
	@see https://developer.mozilla.org/en/XMLHttpRequest XMLHttpRequest - MDN Docs
	@example
		// some.xml
		<data>
			<li>ù��°</li>
			<li>�ι�°</li>
			<li>����°</li>
		</data>
		
		// client.html
		var oAjax = new $Ajax('some.xml', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				var elData = cssquery.getSingle('data', res.xml());	// ������ XML ��ü�� �����Ѵ�
				$('list').innerHTML = elData.firstChild.nodeValue;
			},
		}).request();
 */
nv.$Ajax.Response.prototype.xml = function() {
	return this._response.responseXML;
};

/**
	text() �޼���� ������ ���ڿ�(String)�� ��ȯ�Ѵ�. XHR�� responseText �� �����ϴ�.
	
	@method text
	@return {String} ���� ���ڿ�. 
	@see https://developer.mozilla.org/en/XMLHttpRequest XMLHttpRequest - MDN Docs
	@example
		// some.php
		<?php
			echo "<li>ù��°</li><li>�ι�°</li><li>����°</li>";
		?>
		
		// client.html
		var oAjax = new $Ajax('some.xml', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				$('list').innerHTML = res.text();	// ������ ���ڿ��� �����Ѵ�.
			},
		}).request();
 */
nv.$Ajax.Response.prototype.text = function() {
	return this._response.responseText.replace(this._regSheild, '');
};

/**
	status() �޼���� HTTP ���� �ڵ带 ��ȯ�Ѵ�. HTTP ���� �ڵ�ǥ�� �����Ѵ�.
	
	@method status
	@return {Numeric} ���� �ڵ�.
	@see http://www.w3.org/Protocols/HTTP/HTRESP.html HTTP Status codes - W3C
	@example
		var oAjax = new $Ajax('some.php', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				if(res.status() == 200){	// HTTP ���� �ڵ带 Ȯ���Ѵ�.
					$('list').innerHTML = res.text();
				}
			},
		}).request();
 */
nv.$Ajax.Response.prototype.status = function() {
	var status = this._response.status;
	return status==0?200:status;
};

/**
	readyState() �޼���� ���� ����(readyState)�� ��ȯ�Ѵ�.
	
	@method readyState
	@return {Numeric} readyState ��.
		@return .0 ��û�� �ʱ�ȭ���� ���� ���� (UNINITIALIZED)
		@return .1 ��û �ɼ��� ����������, ��û���� ���� ���� (LOADING)
		@return .2 ��û�� ������ ó�� ���� ����. �� ���¿��� ���� ����� ���� �� �ִ�. (LOADED)
		@return .3 ��û�� ó�� ���̸�, �κ����� ���� �����͸� ���� ���� (INTERACTIVE)
		@return .4 ���� �����͸� ��� �޾� ����� �Ϸ��� ���� (COMPLETED)
	@example
		var oAjax = new $Ajax('some.php', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				if(res.readyState() == 4){	// ������ readyState �� Ȯ���Ѵ�.
					$('list').innerHTML = res.text();
				}
			},
		}).request();
 */
nv.$Ajax.Response.prototype.readyState = function() {
	return this._response.readyState;
};

/**
	json() �޼���� ������ JSON ��ü�� ��ȯ�Ѵ�. ���� ���ڿ��� �ڵ����� JSON ��ü�� ��ȯ�Ͽ� ��ȯ�Ѵ�. ��ȯ �������� ������ �߻��ϸ� �� ��ü�� ��ȯ�Ѵ�.
	
	@method json
	@return {Object} JSON ��ü.
	@throws {nv.$Except.PARSE_ERROR} json�Ľ��� �� ���� �߻��� ���.
	@example
		// some.php
		<?php
			echo "['ù��°', '�ι�°', '����°']";
		?>
		
		// client.html
		var oAjax = new $Ajax('some.php', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				var welList = $Element('list').empty();
				var jsonData = res.json();	// ������ JSON ��ü�� �����Ѵ�
		
				for(var i = 0, nLen = jsonData.length; i < nLen; i++){
					welList.append($("<li>" + jsonData[i] + "</li>"));
				}
			},
		}).request();
 */
nv.$Ajax.Response.prototype.json = function() {
	if (this._response.responseJSON) {
		return this._response.responseJSON;
	} else if (this._response.responseText) {
		try {
			return eval("("+this.text()+")");
		} catch(e) {
			throw new nv.$Error(nv.$Except.PARSE_ERROR,"$Ajax#json");
		}
	}

	return {};
};

/**
	header() �޼���� ���� ����� �����´�.
	
	@method header
	@syntax sName
	@param {String+} [sName] ������ ���� ����� �̸�. �� �ɼ��� �Է����� ������ ��� ��ü�� ��ȯ�Ѵ�.
	@return {String | Object} �ش��ϴ� ��� ��(String) �Ǵ� ��� ��ü(Object)

	@example
		var oAjax = new $Ajax('some.php', {
			type : 'xhr',
			method : 'get',
			onload : function(res){
				res.header("Content-Length")	// ���� ������� "Content-Length" �� ���� �����Ѵ�.
			},
		}).request();
 */
nv.$Ajax.Response.prototype.header = function(name) {
	var oArgs = g_checkVarType(arguments, {
		'4str' : [ 'name:String+' ],
		'4voi' : [ ]
	},"$Ajax.Response#header");
	
	switch (oArgs+"") {
	case '4str':
		return this._response.getResponseHeader(name);
	case '4voi':
		return this._response.getAllResponseHeaders();
	}
};
//-!nv.$Ajax end!-//

/**
	@fileOverview $Ajax�� Ȯ�� �޼��带 ������ ����
	@name Ajax.extend.js
	@author NAVER Ajax Platform
 */

//-!nv.$Ajax.RequestBase start(nv.$Class,nv.$Ajax)!-//
/**
	Ajax ��û ��ü�� �⺻ ��ü�̴�.

	@class nv.$Ajax.RequestBase
	@ignore
 */
/**
	Ajax ��û Ÿ�� ���� Ajax ��û ��ü�� ������ �� Ajax ��û ��ü�� �����ϱ� ���� ���� ��ü�� ����Ѵ�.
	
	@constructor
	@ignore
	@see nv.$Ajax
 */
var klass = nv.$Class;
nv.$Ajax.RequestBase = klass({
	_respHeaderString : "",
	callbackid:"",
	callbackname:"",
	responseXML  : null,
	responseJSON : null,
	responseText : "",
	status : 404,
	readyState : 0,
	$init  : function(fpOption){},
	onload : function(){},
	abort  : function(){},
	open   : function(){},
	send   : function(){},
	setRequestHeader  : function(sName, sValue) {
		g_checkVarType(arguments, {
			'4str' : [ 'sName:String+', 'sValue:String+' ]
		},"$Ajax.RequestBase#setRequestHeader");
		this._headers[sName] = sValue;
	},
	getResponseHeader : function(sName) {
		g_checkVarType(arguments, {
			'4str' : [ 'sName:String+']
		},"$Ajax.RequestBase#getResponseHeader");
		return this._respHeaders[sName] || "";
	},
	getAllResponseHeaders : function() {
		return this._respHeaderString;
	},
	_getCallbackInfo : function() {
		var id = "";
		if(this.option("callbackid")!="") {
			var idx = 0;
			do {
				id = "_" + this.option("callbackid") + "_"+idx;
				idx++;
			} while (window["__"+nv._p_.nvName+"_callback"][id]);	
		}else{
			do {
				id = "_" + Math.floor(Math.random() * 10000);
			} while (window["__"+nv._p_.nvName+"_callback"][id]);
		}
		
		if(this.option("callbackname") == ""){
			this.option("callbackname","_callback");
		}
		return {callbackname:this.option("callbackname"),id:id,name:"window.__"+nv._p_.nvName+"_callback."+id};
	}
});
//-!nv.$Ajax.RequestBase end!-//

//-!nv.$Ajax.JSONPRequest start(nv.$Class,nv.$Ajax,nv.$Agent.prototype.navigator,nv.$Ajax.RequestBase)!-//
/**
	Ajax ��û Ÿ���� jsonp�� ��û ��ü�� �����ϸ�, nv.$Ajax() ��ü���� Ajax ��û ��ü�� ������ �� ����Ѵ�.
	
	@class nv.$Ajax.JSONPRequest
	@extends nv.$Ajax.RequestBase
	@ignore
 */
/**
	nv.$Ajax.JSONPRequest() ��ü�� �����Ѵ�. �̶�, nv.$Ajax.JSONPRequest() ��ü�� nv.$Ajax.RequestBase() ��ü�� ����Ѵ�.
	
	@constructor
	@ignore
	@see nv.$Ajax
	@see nv.$Ajax.RequestBase
 */
nv.$Ajax.JSONPRequest = klass({
	_headers : {},
	_respHeaders : {},
	_script : null,
	_onerror : null,
	$init  : function(fpOption){
		this.option = fpOption;
	},
	/**
	 * @ignore 
	 */
	_callback : function(data) {
		
		if (this._onerror) {
			clearTimeout(this._onerror);
			this._onerror = null;
		}
			
		var self = this;

		this.responseJSON = data;
		this.onload(this);
		setTimeout(function(){ self.abort(); }, 10);
	},
	abort : function() {
		if (this._script) {
			try { 
				this._script.parentNode.removeChild(this._script); 
			}catch(e){}
		}
	},
	open  : function(method, url) {
		g_checkVarType(arguments, {
			'4str' : [ 'method:String+','url:String+']
		},"$Ajax.JSONPRequest#open");
		this.responseJSON = null;
		this._url = url;
	},
	send  : function(data) {
		var oArgs = g_checkVarType(arguments, {
			'4voi' : [],
			'4nul' : ["data:Null"],
			'4str' : ["data:String+"]
		},"$Ajax.JSONPRequest#send");
		var t    = this;
		var info = this._getCallbackInfo();
		var head = document.getElementsByTagName("head")[0];
		this._script = document.createElement("script");
		this._script.type    = "text/javascript";
		this._script.charset = this.option("jsonp_charset");

		if (head) {
			head.appendChild(this._script);
		} else if (document.body) {
			document.body.appendChild(this._script);
		}
		window["__"+nv._p_.nvName+"_callback"][info.id] = function(data){
			try {
				t.readyState = 4;
				t.status = 200;
				t._callback(data);
			} finally {
				delete window["__"+nv._p_.nvName+"_callback"][info.id];
				delete window["__"+nv._p_.nvName+"2_callback"][info.id];
			}
		};
		window["__"+nv._p_.nvName+"2_callback"][info.id] = function(data){
		    window["__"+nv._p_.nvName+"_callback"][info.id](data);
		};
		
		var agent = nv.$Agent(navigator); 
		var _loadCallback = function(){
			if (!t.responseJSON) {
				t.readyState = 4;

				// when has no response code
				t.status = 500;
				t._onerror = setTimeout(function(){t._callback(null);}, 200);
			}
		};

        // On IE11 'script.onreadystatechange' and 'script.readyState' was removed and should be replaced to 'script.onload'.
        // http://msdn.microsoft.com/en-us/library/ie/bg182625%28v=vs.85%29.aspx
		if (agent.navigator().ie && this._script.readyState) {
			this._script.onreadystatechange = function(){		
				if (this.readyState == 'loaded'){
					_loadCallback();
					this.onreadystatechange = null;
				}
			};
		} else {
			this._script.onload = 
			this._script.onerror = function(){
				_loadCallback();
				this.onerror = null;
				this.onload = null;
			};
		}
		var delimiter = "&";
		if(this._url.indexOf('?')==-1){
			delimiter = "?";
		}
		switch(oArgs+""){
			case "4voi":
			case "4nul":
				data = "";
				break;
			case "4str":
				data = "&" + data;
				
			
		}
		//test url for spec.
		this._test_url = this._script.src = this._url+delimiter+info.callbackname+"="+info.name+data;
		
	}
}).extend(nv.$Ajax.RequestBase);
//-!nv.$Ajax.JSONPRequest end!-//

//-!nv.$Ajax.SWFRequest start(nv.$Class,nv.$Ajax,nv.$Agent.prototype.navigator,nv.$Ajax.RequestBase)!-//
/**
 	Ajax ��û Ÿ���� flash�� ��û ��ü�� �����ϸ�, nv.$Ajax() ��ü���� Ajax ��û ��ü�� ������ �� ����Ѵ�.
	
	@class nv.$Ajax.SWFRequest
	@extends nv.$Ajax.RequestBase
	@filter desktop
 */
/**
 	nv.$Ajax.SWFRequest() ��ü�� �����Ѵ�. �̶�, nv.$Ajax.SWFRequest() ��ü�� nv.$Ajax.RequestBase() ��ü�� ����Ѵ�.
	
	@constructor
	@filter desktop
	@see nv.$Ajax
	@see nv.$Ajax.RequestBase
 */
nv.$Ajax.SWFRequest = klass({
	$init  : function(fpOption){
		this.option = fpOption;
	},
	_headers : {},
	_respHeaders : {},
	_getFlashObj : function(){
		var _tmpId = nv.$Ajax.SWFRequest._tmpId;
		var navi = nv.$Agent(window.navigator).navigator();
		var obj;
		if (navi.ie&&navi.version==9) {
			obj = _getElementById(document,_tmpId);
		}else{
			obj = window.document[_tmpId];
		}
		return(this._getFlashObj = function(){
			return obj;
		})();
		
	},
	_callback : function(status, data, headers){
		this.readyState = 4;
        /*
          ���� ȣȯ�� ���� status�� boolean ���� ��쵵 ó��
         */

		if( nv.$Jindo.isNumeric(status)){
			this.status = status;
		}else{
			if(status==true) this.status=200;
		}		
		if (this.status==200) {
			if (nv.$Jindo.isString(data)) {
				try {
					this.responseText = this.option("decode")?decodeURIComponent(data):data;
					if(!this.responseText || this.responseText=="") {
						this.responseText = data;
					}	
				} catch(e) {
                    /*
                         ������ �ȿ� utf-8�� �ƴ� �ٸ� ���ڵ��϶� ���ڵ��� ���ϰ� �ٷ� text�� ����.
                     */

					if(e.name == "URIError"){
						this.responseText = data;
						if(!this.responseText || this.responseText=="") {
							this.responseText = data;
						}
					}
				}
			}
            /*
             �ݹ��ڵ�� �־�����, ���� SWF���� ������� ���� ����
             */
			if(nv.$Jindo.isHash(headers)){
				this._respHeaders = headers;				
			}
		}
		
		this.onload(this);
	},
	open : function(method, url) {
		g_checkVarType(arguments, {
			'4str' : [ 'method:String+','url:String+']
		},"$Ajax.SWFRequest#open");
		var re  = /https?:\/\/([a-z0-9_\-\.]+)/i;

		this._url    = url;
		this._method = method;
	},
	send : function(data) {
		var cache = nv.$Jindo;
		var oArgs = cache.checkVarType(arguments, {
			'4voi' : [],
			'4nul' : ["data:Null"],
			'4str' : ["data:String+"]
		},"$Ajax.SWFRequest#send");
		this.responseXML  = false;
		this.responseText = "";

		var t = this;
		var dat = {};
		var info = this._getCallbackInfo();
		var swf = this._getFlashObj();

		function f(arg) {
			switch(typeof arg){
				case "string":
					return '"'+arg.replace(/\"/g, '\\"')+'"';
					
				case "number":
					return arg;
					
				case "object":
					var ret = "", arr = [];
					if (cache.isArray(arg)) {
						for(var i=0; i < arg.length; i++) {
							arr[i] = f(arg[i]);
						}
						ret = "["+arr.join(",")+"]";
					} else {
						for(var x in arg) {
							if(arg.hasOwnProperty(x)){
								arr[arr.length] = f(x)+":"+f(arg[x]);	
							}
						}
						ret = "{"+arr.join(",")+"}";
					}
					return ret;
				default:
					return '""';
			}
		}
		data = data?data.split("&"):[];

		var oEach, pos, key, val;
		for(var i=0; i < data.length; i++) {
			oEach = data[i]; 
			pos = oEach.indexOf("=");
			key = oEach.substring(0,pos);
			val = oEach.substring(pos+1);

			dat[key] = decodeURIComponent(val);
		}
		this._current_callback_id = info.id;
		window["__"+nv._p_.nvName+"_callback"][info.id] = function(success, data){
			try {
				t._callback(success, data);
			} finally {
				delete window["__"+nv._p_.nvName+"_callback"][info.id];
			}
		};
		
		window["__"+nv._p_.nvName+"2_callback"][info.id] = function(data){
            window["__"+nv._p_.nvName+"_callback"][info.id](data);
        };
		
		var oData = {
			url  : this._url,
			type : this._method,
			data : dat,
			charset  : "UTF-8",
			callback : info.name,
			header_json : this._headers
		};
		
		swf.requestViaFlash(f(oData));
	},
	abort : function(){
	    var info = this._getCallbackInfo();

		if(this._current_callback_id){
			window["__"+nv._p_.nvName+"_callback"][this._current_callback_id] = function() {
				delete window["__"+nv._p_.nvName+"_callback"][info.id];
				delete window["__"+nv._p_.nvName+"2_callback"][info.id];
			};

			window["__"+nv._p_.nvName+"2_callback"][this._current_callback_id] = function(data){
                window["__"+nv._p_.nvName+"_callback"][this._current_callback_id](data);
            };
		}
	}
}).extend(nv.$Ajax.RequestBase);

/**
	write() �޼���� �÷��� ��ü�� �ʱ�ȭ�ϴ� �޼���μ� write() �޼��带 ȣ���ϸ� ����� ���� �÷��� ��ü�� ���� ���� �߰��Ѵ�. Ajax ��û Ÿ���� flash�̸� �÷��� ��ü�� ���� ����Ѵ�. ���� nv.$Ajax() ��ü�� request �޼��尡 ȣ��Ǳ� ���� write() �޼��带 �ݵ�� �� �� �����ؾ� �ϸ�, <body> ��ҿ� �ۼ��Ǿ�� �Ѵ�. �� �� �̻� �����ص� ������ �߻��Ѵ�.
	
	@method write
	@param {String+} [sSWFPath="./ajax.swf"] Ajax ��ſ� ����� �÷��� ����.
	@filter desktop
	@see nv.$Ajax#request
	@example
		<body>
		    <script type="text/javascript">
		        $Ajax.SWFRequest.write("/path/swf/ajax.swf");
		    </script>
		</body>
 */
nv.$Ajax.SWFRequest.write = function(swf_path) {
    var oArgs = nv.$Jindo.checkVarType(arguments, {
        '4voi' : [],
        '4str' : ["data:String+"]
    },"<static> $Ajax.SWFRequest#write");
    switch(oArgs+""){
        case "4voi":
            swf_path = "./ajax.swf";
        
    }
    var ajax = nv.$Ajax; 
    ajax.SWFRequest._tmpId = 'tmpSwf'+(new Date()).getMilliseconds()+Math.floor(Math.random()*100000);
    var activeCallback = "nv.$Ajax.SWFRequest.loaded";
    var protocol = (location.protocol == "https:")?"https:":"http:";
    var classid = (nv._p_._JINDO_IS_IE?'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"':'');
    ajax._checkFlashLoad();
    
    var body = document.body;
    var nodes = body.childNodes;
    var swf = nv.$("<div style='position:absolute;top:-1000px;left:-1000px' tabindex='-1'>/<div>");
    swf.innerHTML = '<object tabindex="-1" id="'+ajax.SWFRequest._tmpId+'" width="1" height="1" '+classid+' codebase="'+protocol+'//download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"><param name="movie" value="'+swf_path+'"><param name = "FlashVars" value = "activeCallback='+activeCallback+'" /><param name = "allowScriptAccess" value = "always" /><embed tabindex="-1" name="'+ajax.SWFRequest._tmpId+'" src="'+swf_path+'" type="application/x-shockwave-flash" pluginspage="'+protocol+'://www.macromedia.com/go/getflashplayer" width="1" height="1" allowScriptAccess="always" swLiveConnect="true" FlashVars="activeCallback='+activeCallback+'"></embed></object>'; 

    if (nodes.length > 0) {
        body.insertBefore(swf, nodes[0]);
    } else {
        body.appendChild(swf);
    }    
};

/**
 * @ignore
 */
nv.$Ajax._checkFlashLoad = function(){
	nv.$Ajax._checkFlashKey = setTimeout(function(){
		nv.$Ajax.SWFRequest.onerror();
	},5000);
	nv.$Ajax._checkFlashLoad = function(){};
};
/**
	�÷��� ��ü �ε� ���θ� ������ ����. �ε��� ��� true�� ��ȯ�ϰ� �ε����� ���� ��� false�� ��ȯ�Ѵ�. �÷��� ��ü�� �ε��Ǿ����� Ȯ���� �� ����� �� �ִ�.	
	
	@method activeFlash
	@filter desktop
	@see nv.$Ajax.SWFRequest#write
 */
nv.$Ajax.SWFRequest.activeFlash = false;

/**
 * 	flash�� ���������� load �Ϸ�� �� ����Ǵ� �Լ�.
	
	@method onload
	@filter desktop
	@since 2.0.0
	@see nv.$Ajax.SWFRequest#onerror
	@example
		var oSWFAjax = $Ajax("http://naver.com/api/test.json",{
			"type" : "flash"
		});
	    $Ajax.SWFRequest.onload = function(){
			oSWFAjax.request();	
		}
 */
nv.$Ajax.SWFRequest.onload = function(){
};

/**
 * 	flash�� ���������� load �Ϸ���� ������ ����Ǵ� �Լ�.
	
	@method onerror
	@filter desktop
	@see nv.$Ajax.SWFRequest#onerror
	@since 2.0.0
	@example
		var oSWFAjax = $Ajax("http://naver.com/api/test.json",{
			"type" : "flash"
		});
        $Ajax.SWFRequest.onerror = function(){
			alert("flash�ε� ����.�ٽ� �ε��ϼ���!");
		}
 */
nv.$Ajax.SWFRequest.onerror = function(){
};

/**
	flash���� �ε� �� ���� ��Ű�� �Լ�.
	
	@method loaded
	@filter desktop
	@ignore
 */
nv.$Ajax.SWFRequest.loaded = function(){
	clearTimeout(nv.$Ajax._checkFlashKey);
	nv.$Ajax.SWFRequest.activeFlash = true;
	nv.$Ajax.SWFRequest.onload();
};
//-!nv.$Ajax.SWFRequest end!-//

//-!nv.$Ajax.FrameRequest start(nv.$Class,nv.$Ajax,nv.$Ajax.RequestBase)!-//
/**
	nv.$Ajax.FrameRequest() ��ü�� Ajax ��û Ÿ���� iframe�� ��û ???ü�� �����ϸ�, nv.$Ajax() ��ü���� Ajax ��û ��ü�� ������ �� ����Ѵ�.
	
	@class nv.$Ajax.FrameRequest
	@extends nv.$Ajax.RequestBase
	@filter desktop
	@ignore
 */
/**
	nv.$Ajax.FrameRequest() ��ü�� �����Ѵ�. �̶�, nv.$Ajax.FrameRequest() ��ü�� nv.$Ajax.RequestBase() ��ü�� ����Ѵ�.
	
	@constructor
	@filter desktop
	@ignore
	@see nv.$Ajax
	@see nv.$Ajax.RequestBase
 */
nv.$Ajax.FrameRequest = klass({
	_headers : {},
	_respHeaders : {},
	_frame  : null,
	_domain : "",
	$init  : function(fpOption){
		this.option = fpOption;
	},
	_callback : function(id, data, header) {
		var self = this;

		this.readyState   = 4;
		this.status = 200;
		this.responseText = data;

		this._respHeaderString = header;
		header.replace(/^([\w\-]+)\s*:\s*(.+)$/m, function($0,$1,$2) {
			self._respHeaders[$1] = $2;
		});

		this.onload(this);

		setTimeout(function(){ self.abort(); }, 10);
	},
	abort : function() {
		if (this._frame) {
			try {
				this._frame.parentNode.removeChild(this._frame);
			} catch(e) {}
		}
	},
	open : function(method, url) {
		g_checkVarType(arguments, {
			'4str' : [ 'method:String+','url:String+']
		},"$Ajax.FrameRequest#open");
		
		var re  = /https?:\/\/([a-z0-9_\-\.]+)/i;
		var dom = document.location.toString().match(re);
		
		this._method = method;
		this._url    = url;
		this._remote = String(url).match(/(https?:\/\/[a-z0-9_\-\.]+)(:[0-9]+)?/i)[0];
		this._frame = null;
		this._domain = (dom != null && dom[1] != document.domain)?document.domain:"";
	},
	send : function(data) {
		var oArgs = g_checkVarType(arguments, {
			'4voi' : [],
			'4nul' : ["data:Null"],
			'4str' : ["data:String+"]
		},"$Ajax.FrameRequest#send");
		
		this.responseXML  = "";
		this.responseText = "";

		var t      = this;
		var re     = /https?:\/\/([a-z0-9_\-\.]+)/i;
		var info   = this._getCallbackInfo();
		var url;
		var _aStr = [];
		_aStr.push(this._remote+"/ajax_remote_callback.html?method="+this._method);
		var header = [];

		window["__"+nv._p_.nvName+"_callback"][info.id] = function(id, data, header){
			try {
				t._callback(id, data, header);
			} finally {
				delete window["__"+nv._p_.nvName+"_callback"][info.id];
				delete window["__"+nv._p_.nvName+"2_callback"][info.id];
			}
		};
		
		window["__"+nv._p_.nvName+"2_callback"][info.id] = function(id, data, header){
            window["__"+nv._p_.nvName+"_callback"][info.id](id, data, header);
        };

		for(var x in this._headers) {
			if(this._headers.hasOwnProperty(x)){
				header[header.length] = "'"+x+"':'"+this._headers[x]+"'";	
			}
			
		}

		header = "{"+header.join(",")+"}";
		
		_aStr.push("&id="+info.id);
		_aStr.push("&header="+encodeURIComponent(header));
		_aStr.push("&proxy="+encodeURIComponent(this.option("proxy")));
		_aStr.push("&domain="+this._domain);
		_aStr.push("&url="+encodeURIComponent(this._url.replace(re, "")));
		_aStr.push("#"+encodeURIComponent(data));

		var fr = this._frame = document.createElement("iframe");
		var style = fr.style;
		style.position = "absolute";
		style.visibility = "hidden";
		style.width = "1px";
		style.height = "1px";

		var body = document.body || document.documentElement;
		if (body.firstChild){ 
			body.insertBefore(fr, body.firstChild);
		}else{ 
			body.appendChild(fr);
		}
		if(typeof MSApp != "undefined"){
			MSApp.addPublicLocalApplicationUri(this.option("proxy"));
		}
		
		fr.src = _aStr.join("");
	}
}).extend(nv.$Ajax.RequestBase);
//-!nv.$Ajax.FrameRequest end!-//

//-!nv.$Ajax.Queue start(nv.$Ajax)!-//
/**
	nv.$Ajax.Queue() ��ü�� Ajax ��û�� ť�� ��� ť�� ���� ������� ��û�� ó���Ѵ�.
	
	@class nv.$Ajax.Queue
	@keyword ajaxqueue, queue, ajax, ť
 */
/**
	nv.$Ajax() ��ü�� ������� ȣ���� �� �ֵ��� ����� �����Ѵ�.
	
	@constructor
	@param {Hash+} oOption nv.$Ajax.Queue() ��ü�� ������ ����� ��û�� �� ����ϴ� ������ �����Ѵ�.
		@param {Boolean} [oOption.async=false] �񵿱�/���� ��û ����� �����Ѵ�. �񵿱� ��û ����̸� true, ���� ��û ����̸� false�� �����Ѵ�.
		@param {Boolean} [oOption.useResultAsParam=false] ���� ��û ����� ���� ��û�� �Ķ���ͷ� �������� �����Ѵ�. ���� ��û ����� �Ķ���ͷ� �����Ϸ��� true, �׷��� ���� ���� ��� false�� �����Ѵ�.
		@param {Boolean} [oOption.stopOnFailure=false] ���� ��û�� ������ ��� ���� ��û �ߴ� ���θ� �����Ѵ�. ���� ��û�� �ߴ��Ϸ��� true, ��� �����Ϸ��� false�� �����Ѵ�.
	@since 1.3.7
	@see nv.$Ajax
	@example
		// $Ajax ��û ť�� �����Ѵ�.
		var oAjaxQueue = new $Ajax.Queue({
			useResultAsParam : true
		});
 */
nv.$Ajax.Queue = function (option) {
	//-@@$Ajax.Queue-@@//
	var cl = arguments.callee;
	if (!(this instanceof cl)){ return new cl(option||{});}
	
	var oArgs = g_checkVarType(arguments, {
		'4voi' : [],
		'4obj' : ["option:Hash+"]
	},"$Ajax.Queue");
	option = oArgs.option;
	this._options = {
		async : false,
		useResultAsParam : false,
		stopOnFailure : false
	};

	this.option(option);
	
	this._queue = [];	
};

/**
	option() �޼���� nv.$Ajax.Queue() ��ü�� ������ �ɼ� ���� ��ȯ�Ѵ�.
	
	@method option
	@param {String+} vName �ɼ��� �̸�
	@return {Variant} �Է��� �ɼ��� ��ȯ�Ѵ�.
	@see nv.$Ajax.Queue
	@example
		oAjaxQueue.option("useResultAsParam");	// useResultAsParam �ɼ� ���� true �� �����Ѵ�.
 */
/**
	option() �޼���� nv.$Ajax.Queue() ��ü�� ������ �ɼ� ���� Ű�� ������ �����Ѵ�.
	
	@method option
	@syntax sName, vValue
	@syntax oOption
	@param {String+} sName �ɼ��� �̸�(String)
	@param {Variant} [vValue] ������ �ɼ��� ��. ������ �ɼ��� vName�� ������ ��쿡�� �Է��Ѵ�.
	@param {Hash+} oOption �ɼ��� �̸�(String) �Ǵ� �ϳ� �̻��� �ɼ��� ������ ��ü(Object).
	@return {this} ������ �ɼ��� ������ �ν��Ͻ� �ڽ�
	@see nv.$Ajax.Queue
	@example
		var oAjaxQueue = new $Ajax.Queue({
			useResultAsParam : true
		});
		
		oAjaxQueue.option("async", true);		// async �ɼ��� true �� �����Ѵ�.
 */
nv.$Ajax.Queue.prototype.option = function(name, value) {
	var oArgs = g_checkVarType(arguments, {
		's4str' : [ 'sKey:String+', 'sValue:Variant' ],
		's4obj' : [ 'oOption:Hash+' ],
		'g' : [ 'sKey:String+' ]
	},"$Ajax.Queue#option");
	
	switch(oArgs+"") {
		case 's4str':
			this._options[oArgs.sKey] = oArgs.sValue;
			break;
		case 's4obj':
			var oOption = oArgs.oOption;
			try {
				for (var x in oOption) {
					if (oOption.hasOwnProperty(x)) 
						this._options[x] = oOption[x];
				}
			}catch(e) {}
			break;
		case 'g':
			return this._options[oArgs.sKey];
	}

	return this;
};

/**
	add() �޼���� $Ajax.Queue�� Ajax ��û(nv.$Ajax() ��ü)�� �߰��Ѵ�.
	
	@method add
	@syntax oAjax, oParam
	@param {nv.$Ajax} oAjax �߰��� nv.$Ajax() ��ü.
	@param {Hash+} [oParam] Ajax ��û �� ������ �Ķ���� ��ü.
	@return {this} �ν��Ͻ� �ڽ� 
	@example
		var oAjax1 = new $Ajax('ajax_test.php',{
			onload :  function(res){
				// onload �ڵ鷯
			}
		});
		var oAjax2 = new $Ajax('ajax_test.php',{
			onload :  function(res){
				// onload �ڵ鷯
			}
		});
		var oAjax3 = new $Ajax('ajax_test.php',{
			onload :  function(res){
				// onload �ڵ鷯
			}
		
		});
		
		var oAjaxQueue = new $Ajax.Queue({
			async : true,
			useResultAsParam : true,
			stopOnFailure : false
		});
		
		// Ajax ��û�� ť�� �߰��Ѵ�.
		oAjaxQueue.add(oAjax1);
		
		// Ajax ��û�� ť�� �߰��Ѵ�.
		oAjaxQueue.add(oAjax1,{seq:1});
		oAjaxQueue.add(oAjax2,{seq:2,foo:99});
		oAjaxQueue.add(oAjax3,{seq:3});
		
		oAjaxQueue.request();
 */
nv.$Ajax.Queue.prototype.add = function (oAjax, oParam) {
	var oArgs = g_checkVarType(arguments, {
		'4obj' : ['oAjax:Hash+'],
		'4obj2' : ['oAjax:Hash+','oPram:Hash+']
	},"$Ajax.Queue");
	switch(oArgs+""){
		case "4obj2":
			oParam = oArgs.oPram;
	}
	
	this._queue.push({obj:oAjax, param:oParam});
	return this;
};

/**
	request() �޼���� $Ajax.Queue�� �ִ� Ajax ��û�� ������ ������.
	
	@method request
	@return {this} �ν��Ͻ� �ڽ� 
	@example
		var oAjaxQueue = new $Ajax.Queue({
			useResultAsParam : true
		});
		oAjaxQueue.add(oAjax1,{seq:1});
		oAjaxQueue.add(oAjax2,{seq:2,foo:99});
		oAjaxQueue.add(oAjax3,{seq:3});
		
		// ������ Ajax ��û�� ������.
		oAjaxQueue.request();
 */
nv.$Ajax.Queue.prototype.request = function () {
	this._requestAsync.apply(this,this.option('async')?[]:[0]);
	return this;
};

nv.$Ajax.Queue.prototype._requestSync = function (nIdx, oParam) {
	var t = this;
	var queue = this._queue;
	if (queue.length > nIdx+1) {
		queue[nIdx].obj._oncompleted = function(bSuccess, oResult){
			if(!t.option('stopOnFailure') || bSuccess) t._requestSync(nIdx + 1, oResult);
		};
	}
	var _oParam = queue[nIdx].param||{};
	if(this.option('useResultAsParam') && oParam){
		try { for(var x in oParam) if(_oParam[x] === undefined && oParam.hasOwnProperty(x)) _oParam[x] = oParam[x]; } catch(e) {}
	}
	queue[nIdx].obj.request(_oParam);
};

nv.$Ajax.Queue.prototype._requestAsync = function () {
	for( var i=0; i<this._queue.length; i++)
		this._queue[i].obj.request(this._queue[i].param||{});
};
//-!nv.$Ajax.Queue end!-//


!function() {
    // Add nv._p_.addExtension method to each class.
    var aClass = [ "$Agent","$Ajax","$A","$Cookie","$Date","$Document","$Element","$ElementList","$Event","$Form","$Fn","$H","$Json","$S","$Template","$Window" ],
        sClass, oClass;

    for(var i=0, l=aClass.length; i<l; i++) {
        sClass = aClass[i];
        oClass = nv[sClass];

        if(oClass) {
            oClass.addExtension = (function(sClass) {
                return function(sMethod,fpFunc){
                    nv._p_.addExtension(sClass,sMethod,fpFunc);
                    return this;
                };
            })(sClass);
        }
    }

    // Add hook method to $Element and $Event
    var hooks = ["$Element","$Event"];

    for(var i=0, l=hooks.length; i<l; i++) {
        var _className = hooks[i];
        if(nv[_className]) {
            nv[_className].hook = (function(className) {
                var __hook = {};
                return function(sName, vRevisionKey) {

                    var oArgs = nv.$Jindo.checkVarType(arguments, {
                        'g'  : ["sName:String+"],
                        's4var' : ["sName:String+", "vRevisionKey:Variant"],
                        's4obj' : ["oObj:Hash+"]
                    },"nv."+className+".hook");

                    switch(oArgs+"") {
                        case "g":
                            return __hook[oArgs.sName.toLowerCase()];
                        case "s4var":
                            if(vRevisionKey == null){
                                delete __hook[oArgs.sName.toLowerCase()];
                            } else {
                                __hook[oArgs.sName.toLowerCase()] = vRevisionKey;
                            }

                            return this;
                        case "s4obj":
                            var oObj = oArgs.oObj;
                            for(var i in oObj) {
                                __hook[i.toLowerCase()] = oObj[i];
                            }

                            return this;
                    }
                };
            })(_className);
        }
    }

    //-!nv.$Element.unload.hidden start!-//
    if(!nv.$Jindo.isUndefined(window)&& !(nv._p_._j_ag.indexOf("IEMobile") == -1 && nv._p_._j_ag.indexOf("Mobile") > -1 && nv._p_._JINDO_IS_SP)) {
        (new nv.$Element(window)).attach("unload",function(e) {
            nv.$Element.eventManager.cleanUpAll();
        });
    }
    //-!nv.$Element.unload.hidden end!-//

    // Register as a named AMD module
    if(typeof define === "function" && define.amd) {
        define("nv", [], function() { return nv; });
    }
}();;/**
 * @constructor
 * @description NAVER Login authorize API
 * @author juhee.lee@nhn.com
 * @version 0.0.1
 * @date 14. 11. 21
 * @copyright 2014 Licensed under the MIT license.
 * @param {PropertiesHash} htOption
 * @param {string} htOption.client_id ���ø����̼� ��� �� �ο� ���� id
 * @param {string} htOption.client_secret ���ø����̼� ��� �� �ο� ���� secret
 * @param {string} htOption.redirect_uri ��Ŭ�����̼� ��� �� �Է��� redirect uri
 * @returns {{api: Function, checkAuthorizeState: Function, getAccessToken: Function, updateAccessToken: Function, logout: Function, login: Function}}
 * @example
 * var naver = NaverAuthorize({
 *   client_id : "���ø����̼� id",
 *   client_secret : "���ø����̼� secret",
 *   redirect_uri : "redirect uri"
 * });
 */
NaverAuthorize = function(htOption) {
    var SERVICE_PROVIDER = "NAVER",
        URL = {
            LOGIN : "https://nid.naver.com/oauth2.0/authorize",
            AUTHORIZE : "https://nid.naver.com/oauth2.0/token",
            API : "https://apis.naver.com/nidlogin/nid/getUserProfile.json?response_type=json"
        },
        GRANT_TYPE = {
            "AUTHORIZE" : "authorization_code",
            "REFRESH" : "refresh_token",
            "DELETE" : "delete"
        };

    var client_id = htOption.client_id,
        client_secret = htOption.client_secret,
        redirect_uri = htOption.redirect_uri,
        code, state_token;


    /**
     * ajax ��� ��ü ����
     * @ignore
     * @param {string} sUrl ȣ���� ������ URL
     * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
     * @returns {*}
     * @private
     */
    _ajax = function(sUrl, callback) {
        return nv.$Ajax(sUrl, {
            type : 'jsonp',
            method : 'get',
            callbackname: 'oauth_callback',
            timeout : 3,
            onload : function(data) {
                console .log("test");
                callback(data);
            },
            ontimeout : function() {
                callback({"error":"timeout"});
            },
            onerror : function() {
                callback({"error" : "fail"});
            }
        });
    };

    /**
     * queryString���� ���� ���� �Ķ������ �� ����
     * @ignore
     * @param {string} name queryString�� key �̸�
     * @returns {*}
     * @private
     */
    _getUrlParameter = function(name) {
        var page_url = window.location.search.substring(1),
            key, values  = page_url.split("&"),
            count = values.length, i;

        for(i=0; i<count; i++) {
            key = values[i].split("=");
            if(key[0] == name) {
                return key[1];
            }
        }

        return null;
    };

    _getUrlParameterValue = function(key){
        var url = location.href
        key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
        var regexS = "[\\?&]"+key+"=([^&#]*)";
        var regex = new RegExp( regexS );
        var results = regex.exec( url );
        return results == null ? null : results[1];
    }

    /**
     * �α��� ���� �ڵ尡 �ִ��� Ȯ��
     * @ignore
     * @returns {boolean}
     * @private
     */
    _hasAuthorizeCode = function() {
        code = _getUrlParameterValue("code");
//        code = _getUrlParameter("code");
        return (code !== null);
    };

    /**
     * state token �� �´��� Ȯ��
     * @ignore
     * @param {string} token state ��ū
     * @returns {boolean}
     * @private
     */
    _isStateToken = function(token) {
//        state_token = _getUrlParameter("state");
        state_token = _getUrlParameterValue("state");
        return (state_token !== null && state_token === token);
    };

    /**
     * ����� ������ ��û
     * @ignore
     * @param {string} access_token access ��ū
     * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
     * @private
     */
    _getUserInfo = function(access_token, callBack) {
        _ajax(URL.API, callBack).request({
            "Authorization": encodeURIComponent("Bearer " + access_token)
        });
    };

    /**
     * Access Token ����
     * @ignore
     * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
     * @private
     */
    _createAccessToken = function(callBack) {
        _ajax(URL.AUTHORIZE, callBack).request({
            "grant_type" : GRANT_TYPE.AUTHORIZE,
            "client_id" : client_id,
            "client_secret" : client_secret,
            "code" : code,
            "state" : state_token
        });
    };

    /**
     * Access Token ����
     * @ignore
     * @param {string} refresh_token refresh ��ū
     * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
     * @private
     */
    _updateAccessToken = function(refresh_token, callBack) {
        _ajax(URL.AUTHORIZE, callBack).request({
            "grant_type" : GRANT_TYPE.REFRESH,
            "client_id" : client_id,
            "client_secret" : client_secret,
            "refresh_token" : refresh_token
        });
    };

    /**
     * Access Token ����
     * @ignore
     * @param {string} access_token access ��ū
     * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
     * @private
     */
    _removeAccessToken = function(access_token, callBack) {
        _ajax(URL.AUTHORIZE, callBack).request({
            "grant_type" : GRANT_TYPE.DELETE,
            "client_id" : client_id,
            "client_secret" : client_secret,
            "access_token" : encodeURIComponent(access_token),
            "service_provider" : SERVICE_PROVIDER
        });
    };


    return {
        /**
         * API ȣ�� �Լ�
         * @param {string} method ȣ���� API ��ɾ� (/me : ����� ������ ��û)
         * @param {string} access_token access ��ū
         * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
         */
        api : function(method, access_token, callBack) {
            if(method === "/me") {
                _getUserInfo(access_token, callBack);
            }
            else {
                _ajax(method, callBack).request({
                    "Authorization": "Bearer " + access_token
                });
            }
        },

        /**
         * �α��� ���� ���¸� Ȯ��
         * @param {string} state_token state ��ū
         * @returns {string} ���� �޽���
         */
        checkAuthorizeState : function(state_token) {
            var error = _getUrlParameterValue("error");

            if(error !== null) {
                return error;
            }

            if(_hasAuthorizeCode() && _isStateToken(state_token)) {
                return "connected";
            }

            return "not_available_state";
        },

        /**
         * Access Token �� ������
         * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
         */
        getAccessToken : function(callBack) {
            _createAccessToken(callBack);
        },

        /**
         * Access Token �� ������Ʈ�Ͽ� ������
         * @param {string} refresh_token refresh ��ū
         * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
         */
        updateAccessToken : function(refresh_token, callBack) {
            _updateAccessToken(refresh_token, callBack);
        },

        /**
         * �α׾ƿ�
         * @param {string} access_token access ��ū
         * @param {requestCallback} callback ������ �� �� ȣ�� �� �ݹ�
         */
        logout : function(access_token, callBack) {
            _removeAccessToken(access_token, callBack)
        },

        /**
         * �α���
         * @param {string} state_token state ��ū
         */
        login : function(state_token) {
//            alert(URL.LOGIN)
            document.location.href = URL.LOGIN + "?client_id=" + client_id + "&response_type=code&redirect_uri=" + encodeURIComponent(redirect_uri) + "&state=" + state_token;
        }
    };

}    

