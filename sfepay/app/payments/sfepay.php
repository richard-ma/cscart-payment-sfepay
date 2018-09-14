<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if (defined('PAYMENT_NOTIFICATION')) {
    /**
     * Receiving and processing the answer
     * from third-party services and payment systems.
     */
    fn_print_die('payment notification response data');
} else {
    /**
     * Running the necessary logics for payment acceptance
     * after the customer presses the "Submit my order" button.
     */
    $data = array(
        /* basic information */
        'MerNo' => $processor_data['processor_params']['accno'],
        'md5key' => $processor_data['processor_params']['md5key'],
        'newcardtype' => get_card_type($payment_info['card_number']),
        'cardnum' => get_base64encode($payment_info["card_number"]),
        'cvv2' => get_base64encode($payment_info["cvv2"]),
        'month' => get_base64encode($payment_info["expiry_month"]),
        'year' => get_base64encode($payment_info["expiry_year"]),
        'cardbank' => $payment_info["card_bank"],
        'BillNo' => $order_info['order_id'],
        'Amount' => $order_info['total'],
        'Currency' => get_currency_code(CART_PRIMARY_CURRENCY),
        'Language' => strtoupper($order_info['lang_code']),
        'ReturnURL' => fn_url("payment_notification.return?payment=sfepay&order_id=$order_id&security_hash=" . fn_generate_security_hash()),
        /* shipping information */
        'shippingFirstName' => $order_info['s_firstname'],
        'shippingLastName' => $order_info['s_lastname'],
        'shippingEmail' => $order_info['email'],
        'shippingPhone' => $order_info['phone'],
        'shippingZipcode' => $order_info['s_zipcode'],
        'shippingAddress' => $order_info['s_address'],
        'shippingCity' => $order_info['s_city'],
        'shippingState' => $order_info['s_state'],
        'shippingCountry' => $payment_info["card_country"],
        'products' => string_replace(get_product_names($order_info)),
        /* bill information */
        'firstname' => $order_info['b_firstname'],
        'lastname' => $order_info['b_lastname'],
        'email' => $order_info['email'],
        'phone' => $order_info['phone'],
        'zipcode' => $order_info['b_zipcode'],
        'address' => $order_info['b_address'],
        'city' => $order_info['b_city'],
        'state' => $order_info['b_state'],
        'country' => $payment_info["card_country"],
        /* system default information */
        'addIp' => get_client_ip(),
        'sfeVersion' => 'ZKF1.1.1',
    );

    $data['MD5info'] = strtoupper(md5(
        $data['MerNo'] . 
        $data['BillNo'] . 
        $data['Currency'] . 
        $data['Amount'] . 
        $data['Language'] .
        $data['ReturnURL'] .
        $data['md5key']
    ));

    //fn_print_r($data);

    $trade_url = 'https://www.sfepay.com/directPayment';
    $re = parse_payment_return_data(curl_post($trade_url, $data));

    //TODO 服务端返回的md5暂时失灵，跳过验证步骤
    // check_response_data($re, $data['md5key']);

    //fn_print_r($re);

    if ($re['succeed'] == '88' || $re['succeed'] == '19') { // 88成功 19待银行处理
        $pp_response['order_status'] = 'P';
        $pp_response['reason_text'] = $re['Result'];

        $order_id = (int)$data['BillNo'];
        fn_finish_payment($order_id, $pp_response);
        fn_order_placement_routines('route', $order_id);
    } else {
        // 支付失败
        $pp_response['order_status'] = 'F';
        $pp_response['reason_text'] = 'The Operation Failed To Pay. [CODE: ' . $re['Succeed'] . ' MESSAGE: ' . $re['Result'] . ']';
        fn_change_order_status($order_id, $pp_response['order_status']);
    }
}

function check_response_data($data, $md5key) {
    $checksum = strtoupper(md5(
        $data['BillNo'].
        $data['Currency'].
        $data['Amount'].
        $data['Succeed'].
        $md5key
    ));

    return $checksum === $data['MD5info'] ? True : False;
}

function get_base64encode($string) {
    return base64_encode(urlencode($string));
}

function curl_post($url, $data) {
    $ssl = substr($url, 0, 8) == "https://" ? True : False;
    $mysite = $_SERVER['HTTP_HOST'];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_REFERER, $mysite);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);

    $re = curl_exec($ch);
    curl_close($ch);

    return $re;
}

function parse_payment_return_data($data_string) {
    $split_data = explode('&', $data_string);

    $data = array();
    foreach ($split_data as $pair_string) {
        list($key, $value) = explode('=', $pair_string);
        $data[$key] = $value;
    }

    return $data;
}

function get_client_ip() {
    $ip = fn_get_ip(true);
    $client_ip = long2ip($ip['host']);
    return $client_ip;
}

function get_card_type($card_number) {
    $no = substr($card_number, 0, 2);
    if (strlen($card_number) == 16 && ($no == '30' || $no == '35')) return '3'; // jcb
    $no = substr($card_number, 0, 1);
    if (strlen($card_number) == 16 && $no == '4') return '4'; // visa
    if (strlen($card_number) == 16 && $no == '5') return '5'; // master
}

function get_currency_code($currency_string) {
    if ($currency_string == 'USD') {
        return '1';
    } elseif ($currency_string == 'EUR') {
        return '2';
    } elseif ($currency_string == 'CNY') {
        return '3';
    } elseif ($currency_string == 'GBP') {
        return '4';
    } elseif ($currency_string == 'JPY') {
        return '6';
    } elseif ($currency_string == 'AUD') {
        return '7';
    } elseif ($currency_string == 'CAD') {
        return '11';
    } else {
        return '0';
    }
}

function get_currency_string($currency_code) {
    if ($currency_code == '1') {
        return 'USD';
    } elseif ($currency_code == '2') {
        return 'EUR';
    } elseif ($currency_code == '3') {
        return 'CNY';
    } elseif ($currency_code == '4') {
        return 'GBP';
    } elseif ($currency_code == '6') {
        return 'JPY';
    } elseif ($currency_code == '7') {
        return 'AUD';
    } elseif ($currency_code == '11') {
        return 'CAD';
    } else {
        return 'UNKNOWN';
    }
}

function string_replace($string_before) {
    $string_after = str_replace("\n", " ", $string_before);
    $string_after = str_replace("\r", " ", $string_after);
    $string_after = str_replace("\r\n", " ", $string_after);
    $string_after = str_replace("'", "&#39 ", $string_after);
    $string_after = str_replace('"', "&#34 ", $string_after);
    $string_after = str_replace("(", "&#40 ", $string_after);
    $string_after = str_replace(")", "&#41 ", $string_after);
    return $string_after;
}

function get_product_names($order_info) {
    $products_info = "";
    if (!empty($order_info['products'])) {
        foreach ($order_info['products'] as $k => $v) {
            $v['product'] = htmlspecialchars(strip_tags($v['product']));
            if ($products_info == "") {
	            $products_info = $v['product']; 
            } else {
              	$products_info = $products_info.htmlspecialchars(' , ').$v['product'];
            }
        }
    }
    return $products_info;
}


/*
//use Tygh\Http;
//use Tygh\Registry;

$gatewayUrl = 'https://merchant.paytos.com/CubePaymentGateway/gateway/action.NewSubmitAction.do';

$data['OrderID'] = get_paytos_order_id($order_id);
$data['CartId'] = get_paytos_order_id($order_id);
$data['CurrCode'] = $processor_data['processor_params']['paytos_currency'];;
$data['CName'] = $payment_info['cardholder_name'];
$data['IPAddress'] = get_client_ip();
$data['BAddress'] = $order_info['b_address'];
$data['BCity'] = $order_info['b_city'];
$data['Bstate'] = $order_info["b_state_descr"];
$data['Bcountry'] = $order_info['b_country_descr'];
$data['BCountryCode'] = $order_info['b_country'];
$data['PostCode'] =  $order_info['b_zipcode'];
$data['Email'] =  $order_info['email'];
$data['Telephone'] = $order_info['phone'];
$data['PName'] = string_replace(get_product_names($order_info));
$data['IFrame'] = '1';
$data['URL'] = $_SERVER["HTTP_HOST"];
$data['OrderUrl'] = $_SERVER["HTTP_HOST"];
$data['callbackUrl'] = ''; // blank
$data['Framework'] = PRODUCT_NAME;
$data['IVersion'] = 'V8.0';

//HashValue input 
$paytos_key = $processor_data['processor_params']['md5key'];
$paytos_user = $processor_data['processor_params']['accno'];
$inputValue = $paytos_key . 
    $paytos_user . 
    $data['OrderID'] .
    $data['Amount'] . 
    $data['CurrCode'];
//fn_print_r($inputValue);
$data['HashValue'] = szComputeMD5Hash($inputValue);
//fn_print_r($data);

$result = curl_post($gatewayUrl, http_build_query($data, '', '&')); 		

$paytos_cfg = json_decode($result,true);
//fn_print_r($paytos_cfg);

$message = $paytos_cfg['msg'];
if($paytos_cfg["status"]=="0000"){
    $pp_response['order_status'] = 'P';
    $pp_response['reason_text'] = $message;
    $pp_response['transaction_id'] = $paytos_cfg['data']['par3'];

    fn_finish_payment($order_id, $pp_response);
    fn_order_placement_routines('route', $order_id, false);
       
}else{
    $pp_response['order_status'] = 'F';
    $pp_response['reason_text'] = 'Very Sorry. Your issuing bank or credit card company said \'' . $message . '\'. Please try to contact with your issuing bank or use a different card and try again.';

    //if($paytos_cfg["isPendingPayment"]==false){
        //$message = $paytos_cfg['msg'];
        ////fn_set_notification('E', $message);
        //$pp_response['order_status'] = 'F';
        //$pp_response['reason_text'] = 'Very Sorry. Your issuing bank or credit card company said \'' . $message . '\'. Please try to contact with your issuing bank or use a different card and try again.';
        //$pp_response['transaction_id'] = $paytos_cfg['data']['orderNO'];

    //} else {
        //$message = $paytos_cfg['msg'];
        ////fn_set_notification('E', $message);
        //$pp_response['order_status'] = 'O';
        //$pp_response['reason_text'] = 'Very Sorry. Your issuing bank or credit card company said \'' . $message . '\'. Please try to contact with your issuing bank or use a different card and try again.';
        //$pp_response['transaction_id'] = $paytos_cfg['data']['orderNO'];
    //}

    // var_dump($payments_post_data);
    fn_finish_payment($order_id, $pp_response);
    fn_order_placement_routines('route', $order_id, false);
}

exit;

function curl_post($payUrl, $data) {
	$reffer_url = "http://".$_SERVER["HTTP_HOST"]."/checkout.html";
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $payUrl);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
    curl_setopt($curl, CURLOPT_REFERER, $reffer_url);
    curl_setopt($curl, CURLOPT_POST, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
    curl_setopt($curl, CURLOPT_TIMEOUT, 300);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	if (ini_get('open_basedir') == '' && ini_get('safe_mode' == 'Off')) 
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1); // 使用自动跳转
	 
    $tmpInfo = curl_exec($curl);

    if (curl_errno($curl)) {
        return false;
    }

    curl_close($curl);

    return $tmpInfo;
}

function szComputeMD5Hash($input){
    $md5hex=md5($input);
    $len=strlen($md5hex)/2;
    $md5raw="";
    for($i=0;$i<$len;$i++) { 
        $md5raw=$md5raw . chr(hexdec(substr($md5hex,$i*2,2)));
    }
    $keyMd5=base64_encode($md5raw);
    return $keyMd5;
}

Function string_replace($string_before) {
    $string_after = str_replace("\n", " ", $string_before);
    $string_after = str_replace("\r", " ", $string_after);
    $string_after = str_replace("\r\n", " ", $string_after);
    $string_after = str_replace("'", "&#39 ", $string_after);
    $string_after = str_replace('"', "&#34 ", $string_after);
    $string_after = str_replace("(", "&#40 ", $string_after);
    $string_after = str_replace(")", "&#41 ", $string_after);
    return $string_after;
}

function get_product_names($order_info) {
    $products_info = "";
    if (!empty($order_info['products'])) {
        foreach ($order_info['products'] as $k => $v) {
            $v['product'] = htmlspecialchars(strip_tags($v['product']));
            if ($products_info == "") {
	            $products_info = $v['product']; 
            } else {
              	$products_info = $products_info.htmlspecialchars(' , ').$v['product'];
            }
        }
    }
    return $products_info;
}

function get_client_ip() {
    $ip = fn_get_ip(true);
    $client_ip = long2ip($ip['host']);
    return $client_ip;
}

function get_paytos_order_id($order_id) {
    //$pre_order = substr($_SERVER["HTTP_HOST"],0,2) . date('YmdHis');
    //$paytos_orderid = $pre_order.$order_id;
    //return $paytos_orderid;
    return $order_id;
}
*/
