Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A5327E1
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFCFF7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 01:05:59 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:41021
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfFCFF6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Jun 2019 01:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkm6ULrj0j4IxpDmWcAMGnVUOCUCnoyJtchSujJeumo=;
 b=FNynID1Kd92nDlMHxJb3vFT+/h1TSoz/mj9tpuW/dvFVaDHM7e1awTxthvi8sfjo/D/pFaXVG2k1mMLwDc3blDVTFWh+hZ/0gZwvFSOPsQ+hzIFnyhVznow8+Wy3C1eu60V85DiOift7OXxa7Bo8EvnLrnNu5yEv33iGd0vwAOE=
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.56.27) by
 VI1PR04MB4383.eurprd04.prod.outlook.com (20.177.55.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Mon, 3 Jun 2019 05:05:53 +0000
Received: from VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86]) by VI1PR04MB4640.eurprd04.prod.outlook.com
 ([fe80::9dfe:752d:9e88:fe86%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 05:05:52 +0000
From:   Udit Kumar <udit.kumar@nxp.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Jimmy Zhao <jimmy.zhao@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Subject: [PATCH] enable acpi support in esdhc driver
Thread-Topic: [PATCH] enable acpi support in esdhc driver
Thread-Index: AQHVGcoEUMaj4kwyFkKXeXa3VdN5BQ==
Date:   Mon, 3 Jun 2019 05:05:52 +0000
Message-ID: <1559538333-362-1-git-send-email-udit.kumar@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::24) To VI1PR04MB4640.eurprd04.prod.outlook.com
 (2603:10a6:803:70::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=udit.kumar@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f74ea63-1467-433b-78bb-08d6e7e126d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4383;
x-ms-traffictypediagnostic: VI1PR04MB4383:
x-microsoft-antispam-prvs: <VI1PR04MB4383FD2DB9313741B4C6DBC891140@VI1PR04MB4383.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(6486002)(14454004)(6436002)(66476007)(36756003)(66946007)(4326008)(66066001)(64756008)(66556008)(256004)(86362001)(25786009)(73956011)(110136005)(66446008)(6512007)(54906003)(68736007)(53936002)(2201001)(99286004)(8936002)(26005)(81166006)(8676002)(186003)(2906002)(50226002)(5660300002)(316002)(81156014)(6506007)(6116002)(305945005)(44832011)(2616005)(2501003)(476003)(486006)(7736002)(478600001)(52116002)(71200400001)(3846002)(102836004)(71190400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4383;H:VI1PR04MB4640.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bh4xtbp+1n3So3sDO0yNBOF05ubnT1oFFGiis0bUn8WG2FROMccJ6Xg+L9ZF+C4NQjCcAPk0eStM/u6bsmKlbYXXUpBhXj03lIJUwzbcpL8NEaGRYuaJKVD9EJfBd07SvAXEwF9q5o9B/HAd+uOQ6xRVyOokZXPULIkP3CtPTv/D95S0jwN7IZaJS6o2tWKIzX7r88UOVA9LZ003sv/YxHkJoaawFD2Oug8Le8+p8cDcuaxRtarkL9GSQLGYT+sRs04kKKR6LMoIomaFRAo4oNpIVre/Tton1dcW8mq4e8X/g6nOsKm9ooQPH1dgBDCAJkuvVcmM3bkfVbzZUuEXcCWMkUa9Gbdm1ouaNy8krzTMoZyQY5wNheoMhHfZGX1NZ7Qwej0wg031A6ZzeDTPOdJo1L62/wyriYNLEEptzNY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f74ea63-1467-433b-78bb-08d6e7e126d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 05:05:52.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udit.kumar@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4383
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhpcyBwYWN0aCBlbmFibGVzIGFjcGkgc3VwcG9ydCBpbiBlc2RoYyBkcml2ZXINCg0KU2lnbmVk
LW9mZi1ieTogVWRpdCBLdW1hciA8dWRpdC5rdW1hckBueHAuY29tPg0KLS0tDQogZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jIHwgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDE5IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQppbmRleCBlMjBjMDBmLi4xMWQ5
ZjQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQorKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCkBAIC0zLDYgKzMsNyBAQA0KICAq
DQogICogQ29weXJpZ2h0IChjKSAyMDA3LCAyMDEwLCAyMDEyIEZyZWVzY2FsZSBTZW1pY29uZHVj
dG9yLCBJbmMuDQogICogQ29weXJpZ2h0IChjKSAyMDA5IE1vbnRhVmlzdGEgU29mdHdhcmUsIElu
Yy4NCisgKiBDb3B5cmlnaHQgMjAxOSBOWFANCiAgKg0KICAqIEF1dGhvcnM6IFhpYW9ibyBYaWUg
PFguWGllQGZyZWVzY2FsZS5jb20+DQogICoJICAgIEFudG9uIFZvcm9udHNvdiA8YXZvcm9udHNv
dkBydS5tdmlzdGEuY29tPg0KQEAgLTEzLDYgKzE0LDcgQEANCiAgKiB5b3VyIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uDQogICovDQogDQorI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCiAjaW5j
bHVkZSA8bGludXgvZXJyLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQogI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQpAQCAtNzUsNiArNzcsMTIgQEAgc3RydWN0IGVzZGhjX2Nsa19maXh1cCB7DQog
fTsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBzZGhjaV9lc2RoY19vZl9tYXRjaCk7DQogDQor
c3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBzZGhjaV9lc2RoY19pZHNbXSA9IHsN
CisJeyJOWFAwMDAzIiB9LA0KKwl7IC8qIHNlbnRpbmVsICovIH0sDQorfTsNCitNT0RVTEVfREVW
SUNFX1RBQkxFKGFjcGksIHNkaGNpX2VzZGhjX2lkcyk7DQorDQogc3RydWN0IHNkaGNpX2VzZGhj
IHsNCiAJdTggdmVuZG9yX3ZlcjsNCiAJdTggc3BlY192ZXI7DQpAQCAtMTAzOCwyMiArMTA0Niwy
OCBAQCBzdGF0aWMgdm9pZCBlc2RoY19pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
IHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KIAltYXRjaCA9IG9mX21hdGNoX25vZGUoc2RoY2lf
ZXNkaGNfb2ZfbWF0Y2gsIHBkZXYtPmRldi5vZl9ub2RlKTsNCiAJaWYgKG1hdGNoKQ0KIAkJZXNk
aGMtPmNsa19maXh1cCA9IG1hdGNoLT5kYXRhOw0KLQlucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0K
LQljbGsgPSBvZl9jbGtfZ2V0KG5wLCAwKTsNCi0JaWYgKCFJU19FUlIoY2xrKSkgew0KLQkJLyoN
Ci0JCSAqIGVzZGhjLT5wZXJpcGhlcmFsX2Nsb2NrIHdvdWxkIGJlIGFzc2lnbmVkIHdpdGggYSB2
YWx1ZQ0KLQkJICogd2hpY2ggaXMgZVNESEMgYmFzZSBjbG9jayB3aGVuIHVzZSBwZXJpcGVyYWwg
Y2xvY2suDQotCQkgKiBGb3IgbHMxMDQ2YSwgdGhlIGNsb2NrIHZhbHVlIGdvdCBieSBjb21tb24g
Y2xrIEFQSSBpcw0KLQkJICogcGVyaXBoZXJhbCBjbG9jayB3aGlsZSB0aGUgZVNESEMgYmFzZSBj
bG9jayBpcyAxLzINCi0JCSAqIHBlcmlwaGVyYWwgY2xvY2suDQotCQkgKi8NCi0JCWlmIChvZl9k
ZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImZzbCxsczEwNDZhLWVzZGhjIikpDQotCQkJZXNkaGMt
PnBlcmlwaGVyYWxfY2xvY2sgPSBjbGtfZ2V0X3JhdGUoY2xrKSAvIDI7DQotCQllbHNlDQotCQkJ
ZXNkaGMtPnBlcmlwaGVyYWxfY2xvY2sgPSBjbGtfZ2V0X3JhdGUoY2xrKTsNCiANCi0JCWNsa19w
dXQoY2xrKTsNCisJbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJLy8gaW4gY2FzZSBvZiBkZXZp
Y2UgdHJlZSwgZ2V0IGNsb2NrIGZyYW1lIHdvcmsNCisJaWYgKG5wKSB7DQorCQljbGsgPSBvZl9j
bGtfZ2V0KG5wLCAwKTsNCisJCWlmICghSVNfRVJSKGNsaykpIHsNCisJCQkvKg0KKwkJCSAqIGVz
ZGhjLT5wZXJpcGhlcmFsX2Nsb2NrIHdvdWxkIGJlIGFzc2lnbmVkIGEgdmFsdWUNCisJCQkgKiB3
aGljaCBpcyBlU0RIQyBiYXNlIGNsb2NrIHdoZW4gdXNlIHBlcmlwZXJhbCBjbG9jay4NCisJCQkg
KiBGb3IgbHMxMDQ2YSwgdGhlIGNsb2NrIHZhbHVlIGdvdCBieSBjb21tb24gY2xrIEFQSSBpcw0K
KwkJCSAqIHBlcmlwaGVyYWwgY2xvY2sgd2hpbGUgdGhlIGVTREhDIGJhc2UgY2xvY2sgaXMgMS8y
DQorCQkJICogcGVyaXBoZXJhbCBjbG9jay4NCisJCQkgKi8NCisJCQlpZiAob2ZfZGV2aWNlX2lz
X2NvbXBhdGlibGUobnAsICJmc2wsbHMxMDQ2YS1lc2RoYyIpKQ0KKwkJCQllc2RoYy0+cGVyaXBo
ZXJhbF9jbG9jayA9IGNsa19nZXRfcmF0ZShjbGspIC8gMjsNCisJCQllbHNlDQorCQkJCWVzZGhj
LT5wZXJpcGhlcmFsX2Nsb2NrID0gY2xrX2dldF9yYXRlKGNsayk7DQorCQkJY2xrX3B1dChjbGsp
Ow0KKwkJfQ0KKwl9IGVsc2Ugew0KKwkJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKCZwZGV2LT5k
ZXYsICJjbG9jay1mcmVxdWVuY3kiLA0KKwkJCQkJCSZlc2RoYy0+cGVyaXBoZXJhbF9jbG9jayk7
DQogCX0NCiANCiAJaWYgKGVzZGhjLT5wZXJpcGhlcmFsX2Nsb2NrKSB7DQpAQCAtMTA2Miw3ICsx
MDc2LDggQEAgc3RhdGljIHZvaWQgZXNkaGNfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LCBzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCiAJCXZhbCB8PSBFU0RIQ19QRVJJUEhFUkFM
X0NMS19TRUw7DQogCQlzZGhjaV93cml0ZWwoaG9zdCwgdmFsLCBFU0RIQ19ETUFfU1lTQ1RMKTsN
CiAJCWVzZGhjX2Nsb2NrX2VuYWJsZShob3N0LCB0cnVlKTsNCi0JfQ0KKwl9IGVsc2UNCisJCVdB
Uk5fT04oMSk7DQogfQ0KIA0KIHN0YXRpYyBpbnQgZXNkaGNfaHM0MDBfcHJlcGFyZV9kZHIoc3Ry
dWN0IG1tY19ob3N0ICptbWMpDQpAQCAtMTA4MSw5ICsxMDk2LDEwIEBAIHN0YXRpYyBpbnQgc2Ro
Y2lfZXNkaGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJbnAgPSBw
ZGV2LT5kZXYub2Zfbm9kZTsNCiANCi0JaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImxp
dHRsZS1lbmRpYW4iKSkNCisJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woJnBkZXYtPmRl
diwgImxpdHRsZS1lbmRpYW4iKSkgew0KIAkJaG9zdCA9IHNkaGNpX3BsdGZtX2luaXQocGRldiwg
JnNkaGNpX2VzZGhjX2xlX3BkYXRhLA0KIAkJCQkJc2l6ZW9mKHN0cnVjdCBzZGhjaV9lc2RoYykp
Ow0KKwl9DQogCWVsc2UNCiAJCWhvc3QgPSBzZGhjaV9wbHRmbV9pbml0KHBkZXYsICZzZGhjaV9l
c2RoY19iZV9wZGF0YSwNCiAJCQkJCXNpemVvZihzdHJ1Y3Qgc2RoY2lfZXNkaGMpKTsNCkBAIC0x
MTQzLDggKzExNTksOCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldCA9IG1tY19vZl9wYXJzZShob3N0LT5tbWMpOw0KIAlp
ZiAocmV0KQ0KIAkJZ290byBlcnI7DQotDQotCW1tY19vZl9wYXJzZV92b2x0YWdlKG5wLCAmaG9z
dC0+b2NyX21hc2spOw0KKwlpZiAobnApDQorCQltbWNfb2ZfcGFyc2Vfdm9sdGFnZShucCwgJmhv
c3QtPm9jcl9tYXNrKTsNCiANCiAJcmV0ID0gc2RoY2lfYWRkX2hvc3QoaG9zdCk7DQogCWlmIChy
ZXQpDQpAQCAtMTE2MCw2ICsxMTc2LDcgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkuZHJpdmVyID0gew0KIAkJLm5hbWUgPSAi
c2RoY2ktZXNkaGMiLA0KIAkJLm9mX21hdGNoX3RhYmxlID0gc2RoY2lfZXNkaGNfb2ZfbWF0Y2gs
DQorCQkuYWNwaV9tYXRjaF90YWJsZSAgICAgICA9IHNkaGNpX2VzZGhjX2lkcywNCiAJCS5wbSA9
ICZlc2RoY19vZl9kZXZfcG1fb3BzLA0KIAl9LA0KIAkucHJvYmUgPSBzZGhjaV9lc2RoY19wcm9i
ZSwNCi0tIA0KMS45LjENCg0K
