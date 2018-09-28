{script src="js/lib/inputmask/jquery.inputmask.min.js"}
{script src="js/lib/creditcardvalidator/jquery.creditCardValidator.js"}

{if $card_id}
    {assign var="id_suffix" value="`$card_id`"}
{else}
    {assign var="id_suffix" value=""}
{/if}

<div class="clearfix">
    <div class="ty-credit-card">
            <div class="ty-credit-card__control-group ty-control-group">
                <label for="credit_card_number_{$id_suffix}" class="ty-control-group__title cm-cc-number cm-required">{__("card_number")}</label>
                <input size="35" type="text" id="credit_card_number_{$id_suffix}" name="payment_info[card_number]" value="" class="ty-credit-card__input cm-focus cm-autocomplete-off" />
                <ul class="ty-cc-icons cm-cc-icons">
                    <li class="ty-cc-icons__item cc-default cm-cc-default"><span class="ty-cc-icons__icon default">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-visa"><span class="ty-cc-icons__icon visa">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-visa_electron"><span class="ty-cc-icons__icon visa-electron">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-mastercard"><span class="ty-cc-icons__icon mastercard">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-maestro"><span class="ty-cc-icons__icon maestro">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-amex"><span class="ty-cc-icons__icon american-express">&nbsp;</span></li>
                    <li class="ty-cc-icons__item cm-cc-discover"><span class="ty-cc-icons__icon discover">&nbsp;</span></li>
                </ul>
            </div>
    
            <div class="ty-credit-card__control-group ty-control-group">
                <label for="credit_card_month_{$id_suffix}" class="ty-control-group__title cm-cc-date cm-cc-exp-month cm-required">{__("valid_thru")}</label>
                <label for="credit_card_year_{$id_suffix}" class="cm-required cm-cc-date cm-cc-exp-year hidden"></label>
                <input type="text" id="credit_card_month_{$id_suffix}" name="payment_info[expiry_month]" value="" size="2" maxlength="2" class="ty-credit-card__input-short " />&nbsp;&nbsp;/&nbsp;&nbsp;<input type="text" id="credit_card_year_{$id_suffix}"  name="payment_info[expiry_year]" value="" size="2" maxlength="2" class="ty-credit-card__input-short" />&nbsp;
            </div>
    
            <div class="ty-credit-card__control-group ty-control-group">
                <label for="credit_card_name_{$id_suffix}" class="ty-control-group__title cm-required">Card Bank</label>
                <input size="35" type="text" id="credit_card_name_{$id_suffix}" name="payment_info[card_bank]" value="" class="cm-cc-name ty-credit-card__input" />
            </div>
    
            <div class="ty-credit-card__control-group ty-control-group">
                <label for="credit_card_country_{$id_suffix}" class="ty-control-group__title cm-required">Country</label>
                <select id="credit_card_country_{$id_suffix}" name="payment_info[card_country]" class="cm-cc-name ty-credit-card__input">
			        <option value="AFGAF">Afghanistan</option>
				    <option value="ALBAL">Albania</option>
				    <option value="ANDAD">Andorra</option>
				    <option value="AGOAI">Angola</option>
				    <option value="ARMAM">Armenia</option>
				    <option value="ABWAW">Aruba</option>
					<option value="AUSAU">Australia</option>
					<option value="AREAE">United Arab Emirates</option>
					<option value="ARGAR">Argentina</option>
					<option value="ATGAG">Antigua and Barbuda</option>
					<option value="AUTAT">Austria</option>
					<option value="AZEAZ">Azerbaijan</option>
					<option value="ANTAN">Netherlands Antilles</option>
					<option value="BRBBB">Barbados</option>
					<option value="BGDBD">Bangladesh</option>
					<option value="BELBE">Belgium</option>
					<option value="BLZBZ">Belize</option>
					<option value="BENBJ">Benin</option>
					<option value="BTNBT">Bhutan</option>
					<option value="BOLBO">Bolivia</option>
					<option value="BIHBA">Bosnia and Herzegovina</option>
					<option value="BWABW">Botswana</option>
					<option value="BRNBN">Brunei</option>
					<option value="BGRBG">Bulgaria</option>
					<option value="BHRBH">Bahrain</option>
					<option value="BMUBM">Bermuda</option>
					<option value="BRABR">Brazil</option>
					<option value="BHSBS">Bahamas</option>
					<option value="BFABF">Burkina Faso</option>
					<option value="BDIBI">Burundi</option>
					<option value="CMRCM">Cameroon</option>
					<option value="CANCA">Canada</option>
					<option value="CPVCV">Cape Verde</option>
					<option value="CAFCF">Central African Republic</option>
					<option value="COMKM">Comoros</option>
					<option value="COGCG">Congo</option>
					<option value="CHECH">Switzerland</option>
					<option value="CHLCL">Chile</option>
					<option value="COLCO">Colombia</option>
					<option value="CRICR">Costa Rica</option>
					<option value="CYPCY">Cyprus</option>
					<option value="CZECZ">Czech Republic</option>
					<option value="DEUDE">Germany</option>
					<option value="DNKDK">Denmark</option>
					<option value="DJIDJ">Djibouti</option>
					<option value="DZADZ">Algeria</option>
					<option value="DOMDO">Dominican Republic</option>
					<option value="ECUEC">Ecuador</option>
					<option value="EGYEG">Egypt</option>
					<option value="ERIER">Eritrea</option>
					<option value="ESTEE">Estonia</option>
					<option value="ETHET">Ethiopia</option>
					<option value="ESPES">Spain</option>
					<option value="ESHEH">Western Sahara</option>
					<option value="FJIFJ">Fiji</option>
					<option value="FRAFR">France</option>
					<option value="FINFI">Finland</option>
					<option value="GUFGF">French Guiana</option>
					<option value="GABGA">Gabon</option>
					<option value="GMBGM">Gambia</option>
					<option value="GEOGE">Georgia</option>
					<option value="GHAGH">Ghana</option>
					<option value="GIBGI">Gibraltar</option>
					<option value="GRDGD">Grenada</option>
					<option value="GRCGR">Greece</option>
					<option value="GLPGP">Guadeloupe</option>
					<option value="GTMGT">Guatemala</option>
					<option value="GUYGY">Guyana</option>
					<option value="GNBGW">Guinea-Bissau</option>
					<option value="GBRGB">United Kingdom</option>
					<option value="HTIHT">Haiti</option>
					<option value="HNDHN">Honduras</option>
					<option value="HKGHK">Hong Kong</option>
					<option value="HUNHU">Hungary</option>
					<option value="INAID">The Republic of Indonesia</option>
					<option value="IRLIE">Ireland</option>
					<option value="ISRIL">Israel</option>
					<option value="INDIN">India</option>
					<option value="ISLIS">Iceland</option>
					<option value="ITAIT">Italy</option>
					<option value="JAMJM">Jamaica</option>
					<option value="JPNJP">Japan</option>
					<option value="JORJO">Jordan</option>
					<option value="KAZKZ">Kazakhstan</option>
					<option value="KENKE">Kenya</option>
					<option value="KGZKG">Kyrgyzstan</option>
					<option value="KORKR">Korea</option>
					<option value="KWTKW">Kuwait</option>
					<option value="KNAKN">Saint Kitts and Nevis</option>
					<option value="LBNLB">Lebanon</option>
					<option value="LBYLY">Libyan Arab Jamahiriya</option>
					<option value="LIELI">Liechtenstein</option>
					<option value="LKALK">Sri Lanka</option>
					<option value="LTULT">Lithuania</option>
					<option value="LUXLU">Luxembourg</option>
					<option value="LVALV">Latvia</option>
					<option value="LCALC">Saint Lucia</option>
					<option value="MCOMC">Monaco</option>
					<option value="MACMO">Macau</option>
					<option value="MKDMk">Macedonia</option>
					<option value="MDGMG">Madagascar</option>
					<option value="MWIMW">Malawi</option>
					<option value="MDVMV">Maldives</option>
					<option value="MLIML">Mali</option>
					<option value="MLTMT">Malta</option>
					<option value="MTQMQ">Martinique</option>
					<option value="MRTMR">Mauritania</option>
					<option value="MUSMU">Mauritius</option>
					<option value="MEXME">Mexico</option>
					<option value="MYSMY">Malaysia</option>
					<option value="MDAMD">Moldova</option>
					<option value="MNGMN">Mongolia</option>
					<option value="MARMA">Morocco</option>
					<option value="MOZMZ">Mozambique</option>
					<option value="NAMNA">Namibia</option>
					<option value="NPLNP">Nepal</option>
					<option value="NLDNL">Netherlands</option>
					<option value="NICNI">Nicaragua</option>
					<option value="NERNE">Niger</option>
					<option value="NGANG">Nigeria</option>
					<option value="NORNO">Norway</option>
					<option value="NZLNZ">New Zealand</option>
					<option value="OMNOM">Oman</option>
					<option value="PAKPK">Pakistan</option>
					<option value="PANPA">Panama</option>
					<option value="PNGPG">Papua New Guinea</option>
					<option value="PRYPY">Paraguay</option>
					<option value="PERPE">Peru</option>
					<option value="PHLPH">Philippines</option>
					<option value="POLPL">Poland</option>
					<option value="PRTPT">Portugal</option>
					<option value="QATQA">Qatar</option>
					<option value="ROURO">Romania</option>
					<option value="RUSRU">Russian Federation</option>
					<option value="RWARW">Rwanda</option>
					<option value="SMRSM">San Marino</option>
					<option value="STPST">Sao Tome and Principe</option>
					<option value="SAUSA">Saudi Arabia</option>
					<option value="SENSN">Senegal</option>
					<option value="SRBRS">Serbia</option>
					<option value="SWZSZ">Swaziland</option>
					<option value="SYCSC">Seychelles</option>
					<option value="SLESL">Sierra Leone</option>
					<option value="SOMSO">Somalia</option>
					<option value="SURSR">Suriname</option>
					<option value="SWESW">Sweden</option>
					<option value="SGPSG">Singapore</option>
					<option value="SVKSK">Slovakia</option>
					<option value="SVNSI">Slovenia</option>
					<option value="SLVSV">El Salvador</option>
					<option value="SYRSY">Syrian Arab Republic</option>
					<option value="TJKTJ">Tajikistan</option>
					<option value="TZATZ">Tanzania</option>
					<option value="THATH">Thailand</option>
					<option value="TGOTG">Togo</option>
					<option value="TUNTN">Tunisia</option>
					<option value="TURTR">Turkey</option>
					<option value="TTOTT">Trinidad and Tobago</option>
					<option value="TWNTW">Taiwan, Province of China</option>
					<option value="TKMTM">Turkmenistan</option>
					<option value="TCATC">Turks and Caicos Islands</option>
					<option value="UGAUG">Uganda</option>
					<option value="UKRUA">Ukraine</option>
					<option value="USAUS" selected>United States</option>
					<option value="URYUY">Uruguay</option>
					<option value="UZBUZ">Uzbekistan</option>
					<option value="VENVE">Venezuela</option>
					<option value="VCTVC">Saint Vincent and the Grenadines</option>
					<option value="VNMVN">Vietnam</option>
					<option value="YEMYE">Yemen</option>
					<option value="ZMBZM">Zambia</option>
					<option value="ZAFZA">South Africa</option>                
		</select>
            </div>
    </div>
    
    <div class="ty-control-group ty-credit-card__cvv-field cvv-field">
        <label for="credit_card_cvv2_{$id_suffix}" class="ty-control-group__title cm-required cm-integer cm-cc-cvv2 cm-autocomplete-off">{__("cvv2")}</label>
        <input type="text" id="credit_card_cvv2_{$id_suffix}" name="payment_info[cvv2]" value="" size="4" maxlength="4" class="ty-credit-card__cvv-field-input" />

        <div class="ty-cvv2-about">
            <span class="ty-cvv2-about__title">{__("what_is_cvv2")}</span>
            <div class="ty-cvv2-about__note">

                <div class="ty-cvv2-about__info mb30 clearfix">
                    <div class="ty-cvv2-about__image">
                        <img src="{$images_dir}/visa_cvv.png" alt="" />
                    </div>
                    <div class="ty-cvv2-about__description">
                        <h5 class="ty-cvv2-about__description-title">{__("visa_card_discover")}</h5>
                        <p>{__("credit_card_info")}</p>
                    </div>
                </div>
                <div class="ty-cvv2-about__info clearfix">
                    <div class="ty-cvv2-about__image">
                        <img src="{$images_dir}/express_cvv.png" alt="" />
                    </div>
                    <div class="ty-cvv2-about__description">
                        <h5 class="ty-cvv2-about__description-title">{__("american_express")}</h5>
                        <p>{__("american_express_info")}</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

(function(_, $) {
    $.ceEvent('on', 'ce.commoninit', function() {
        var icons = $('.cm-cc-icons li');
        var ccNumber = $(".cm-cc-number");
        var ccNumberInput = $("#" + ccNumber.attr("for"));
        var ccCv2 = $(".cm-cc-cvv2");
        var ccCv2Input = $("#" + ccCv2.attr("for"));
        var ccMonth = $(".cm-cc-exp-month");
        var ccMonthInput = $("#" + ccMonth.attr("for"));
        var ccYear = $(".cm-cc-exp-year");
        var ccYearInput = $("#" + ccYear.attr("for"));

        if(_.isTouch === false && jQuery.isEmptyObject(ccNumberInput.data("_inputmask")) == true) {
            
            ccNumberInput.inputmask("9999 9999 9999 9[99][9]", {
                placeholder: ' '
            });

            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-number',
                message: '',
                func: function(id) {
                    return ccNumberInput.inputmask("isComplete");
                }
            });

            ccCv2Input.inputmask("999[9]", {
                placeholder: ''
            });

            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-cvv2',
                message: "{__("error_validator_ccv")}",
                func: function(id) {
                    return ccCv2Input.inputmask("isComplete");
                }
            });

            ccMonthInput.inputmask("99", {
                placeholder: ''
            });

            ccYearInput.inputmask("99", {
                placeholder: ''
            });

            $.ceFormValidator('registerValidator', {
                class_name: 'cm-cc-date',
                message: '',
                func: function(id) {
                    return (ccYearInput.inputmask("isComplete") && ccMonthInput.inputmask("isComplete"));
                }
            });
        }

        ccNumberInput.validateCreditCard(function(result) {
            icons.removeClass('active');
            if (result.card_type) {
                icons.filter('.cm-cc-' + result.card_type.name).addClass('active');
                if (['visa_electron', 'maestro', 'laser'].indexOf(result.card_type.name) != -1) {
                    ccCv2.removeClass("cm-required");
                } else {
                    ccCv2.addClass("cm-required");
                }
            }
        });
        
    });
})(Tygh, Tygh.$);
</script>
