<%@ page import="net.authorize.sim.*" %>
<%
    String apiLoginId = "59LM95ap7e";
    String transactionKey = "7J77P3C7Rt4bPyeu";
    //String relayResponseUrl = "http://MERCHANT_HOST/relay_response.jsp";
    String relayResponseUrl = "http://182.72.101.50:8094/kycgateway/relay_response.jsp";
    String amount = "1.99";
    Fingerprint fingerprint = Fingerprint.createFingerprint(
        apiLoginId,
        transactionKey,
        1234567890,  // random sequence used for creating the finger print
        amount);

    long x_fp_sequence = fingerprint.getSequence();
    long x_fp_timestamp = fingerprint.getTimeStamp();
    String x_fp_hash = fingerprint.getFingerprintHash();
    //System.out.println("SSSSSS");
    //https://developer.authorize.net/tools/paramdump/index.php testing tool
    //370000000000002
%>

<FORM NAME='secure_redirect_form' ID='secure_redirect_form_id'
 ACTION='https://test.authorize.net/gateway/transact.dll' METHOD='POST'>
  <label>CreditCardNumber</label><input type='text' class='text' name='x_card_num' size='15'>
    </input>
  <label>Exp.</label><input type='text' class='text' name='x_exp_date' size='4'></input>
  <label>Amount</label><input type='text' class='text' name='x_amount' size='9'
    readonly value='<%=amount%>'></input>
  <INPUT TYPE='HIDDEN' NAME='x_invoice_num' VALUE='<%=System.currentTimeMillis()%>'>
  <INPUT TYPE='text' NAME='x_relay_url' VALUE='<%=relayResponseUrl%>'>
  <INPUT TYPE='HIDDEN' NAME='x_login' VALUE='<%=apiLoginId%>'>
  <INPUT TYPE='HIDDEN' NAME='x_fp_sequence' VALUE='<%=x_fp_sequence%>'>
  <INPUT TYPE='HIDDEN' NAME='x_fp_timestamp' VALUE='<%=x_fp_timestamp%>'>
  <INPUT TYPE='HIDDEN' NAME='x_fp_hash' VALUE='<%=x_fp_hash%>'>
  <INPUT TYPE='HIDDEN' NAME='x_version' VALUE='3.1'>
  <INPUT TYPE='HIDDEN' NAME='x_method' VALUE='CC'>
  <INPUT TYPE='HIDDEN' NAME='x_type' VALUE='AUTH_CAPTURE'>
  <INPUT TYPE='HIDDEN' NAME='x_amount' VALUE='<%=amount%>'>
  <INPUT TYPE='HIDDEN' NAME='x_test_request' VALUE='TRUE'>
  <INPUT TYPE='HIDDEN' NAME='notes' VALUE='extra hot please'>
  <INPUT TYPE='SUBMIT' NAME='buy_button' VALUE='BUY'>
  <INPUT TYPE="HIDDEN" NAME="x_relay_response" VALUE="true" />

</FORM>
