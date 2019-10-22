
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">


<head>
    <title>Storage</title>
</head>

<body>

<script type="text/javascript">
//<![CDATA[
    var Storage = (function (win, doc) {
        return function (type, onStorage) {
            function init() {
                this.type = type || 'session';
                
                this.storage = win[this.type === 'local' ? 'localStorage' : 'sessionStorage'];

                this.length = this.storage.length;

                // events
                this.onStorage = onStorage || function () { ; };

                //add evnets
               appendEvent.call(this);
               return this;
            };

            init.prototype =
            {
                set: set,
                get: get,
                remove: remove,
                removeAll: removeAll
            };

            return new init;

        };

        function appendEvent() {
            var that = this;

            // storage 이벤트는 다른 document 기준에서 동일키 값 변경 시 발생된다.
            // (자기 document 안에서는 발생이 되지않는다. 즉, 탭을 하나 열고 테스트한다.)

            bind(window, 'storage', function (e) {
                that.onStorage.apply(that, [e, that.type, e.url, e.key, e.oldValue, e.newValue]);

            });

        };


        // 스토리지 key value 생성

        function set(key, value) {
            key = key || '';


            // JSON 객체담기
            value = value && value.constructor === Object ? JSON.stringify(value) : value;

            this.storage.setItem(key, value);
            this.length = this.storage.length;


            return this;

        };


        // 스토리지 key value 가져오기

        function get(key) {
            var item = this.storage.getItem(key);

            try {
                // JSON 객체 가져오기
                return JSON.parse(item).constructor === Object && JSON.parse(item);

            }


            catch (e) {
                return item;
            }

        };
        // 스토리지 삭제
      function remove(key) {
            this.storage.removeItem(key);
            this.length = this.storage.length;

            return this;

        };

        // 스토리지 전체 삭제
        function removeAll() 


            this.storage.clear();
            this.length = this.storage.length;
            return this;
        };

    })(window, document);

    // 로컬 스토리지 생성
    var local = Storage('local', function (e, type, url, oldValue, newValue) { alert(e); });

    // 세션 스토리지 생성
    var session = Storage('session', function (e, type, url, oldValue, newValue) { alert(e); });

    function add() {
        local.set('key', 'value1');
        session.set('key', 'value1');
    };
    function modify() {
        local.set('key', 'value2')
        session.set('key', {'value2': 'value2'});

    };
    function get(){
        alert(local.get('key'));
        alert(session.get('key').value2);

    };

    function remove() {
    	local.remove('key');
        session.remove('key');

    };

    function removeAll() {
        local.removeAll();
        session.removeAll();

    };

    function length() {
        alert('local-length:' + local.length + ',' + 'session-length:' + session.length);
    }

    // 이벤트 할당
    function bind(elem, type, handler, capture) {
        type = typeof type === 'string' && type || '';

        handler = handler || function () { ; };

        if (elem.addEventListener) {
            elem.addEventListener(type, handler, capture);

        }

        else if (elem.attachEvent) {
            elem.attachEvent('on' + type, handler);
        }

        return elem;
    };
//]]>

</script>

<input type="button" value="storageAppend" onclick="add()" />
<input type="button" value="storageModify" onclick="modify()" />
<input type="button" value="storageGet" onclick="get()" />
<input type="button" value="storageRemove" onclick="remove()" />
<input type="button" value="storageRemoveAll" onclick="removeAll()" />
<input type="button" value="storageLength" onclick="length()" />

</body>

</html>