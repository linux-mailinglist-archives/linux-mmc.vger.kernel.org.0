Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA69085F5A
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Aug 2019 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389834AbfHHKPw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 06:15:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10904 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbfHHKPw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 06:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565259415; x=1596795415;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2oL/Mu/BvLomkqYAR78zTAd9zRov6nUDAw5dIfTzSYs=;
  b=bgwbmfPyVPeRs3vLNHQtFXgaYKXc0rCmDTi+Ymj7e74+/ysoUo/fnIlg
   ucyzvNOq44VYz2KfEClfYHi7o3or6VErCEP/YAv9DLK1TmZBETX0LH3Vv
   aTCnz/7Ua2u6HhDhgtpEsc8O+x2uj94OUIpyZstFAP8YrLElJtyB+y/GU
   iAXP4yJdn7v2pNNorujDr+NeqzIXCSemPOGGp019RCQPdT6rPXXm2PODY
   YjAwZQOc1Hk73QW7fxOZq7Esy44DsDwvsMjRvBfQYD/wSLxlYVDoNr7Q/
   DF/0dPTc7YDuYjAeUqQzRhjTM6WXSaicVtlE9w9uwJ3Rb8KahIL1pz8sO
   g==;
IronPort-SDR: 2TePKCcINyOT8BdH/Yyx6d1RbbpLolOrwE2syWatMvaBU/8wJJAERNNcoA2KPLvdrREakpILww
 l2ZV9/uDdwMMGz2dlat4GLjlAkS/HyvCxV5pZC6PCjB00EdygnP+a0x3mnGv7A9tpaHk7Lww0V
 4gD5T+6dbAChlKYx5vEi+h0k3VOk+bAtHQTtbqYtpbb0QiMHYFacod3CbcDfL0w92pUmlLaDRu
 UJAYa8M3xoBgx9iU+NfaKhGroR+NWMO++yea/pTHJICzOhaTh1zGIaROeiv36jr/qLqhHXVrBL
 pjc=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="215660778"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 18:16:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMDCjsPFHgsu0W75HgFnH8yu0mBqDyEOngYSa5BUceHUjBweqOC8n9h/ftvEkXkwXr1oOqvfpZ95mHUk9VdK41fTKiLa+DxvemvOdbxuxMZsC1TOc2Y2cjFsrHdSCy6c1lIdQqyBNjRnDWB46yX6hGbp8K3LTJW7yGn3tUp2WVgwbqWTJ2I4LZiaQDraIq0KgvGyZJC7trIZ7aQ2rIp334bU5/XuONcGkCg6qNByS/Lkh3IwByuNwB0GOmwj120T0GCeq1I/w5rN29C4F6TKEGv4yspknNOP0QsxQPwv7k2irjA+IjSyoT7ACsq8L29xBgDGznJPWISGABvAWfoKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oL/Mu/BvLomkqYAR78zTAd9zRov6nUDAw5dIfTzSYs=;
 b=i4p4xJBYjHJRbcM6w9WiElirNgtm1huKSo52NNnbUb7tbn9Uw45Fbuud9XV494EXsY4i/PlgQpuf+TsDAhMZOtVB9ozLhZuu9xWp5yy+hsybA3Zh+H4k+tKkgp47+vBTZbNkHi9zNKbjSitBQTruHeglLlYFoPUVhhDYRenmP95VsD1DA/D4msgOBSfcuGBuHfkWsY6T0zawPdR1jm5/OCaePL0nycTeFVgmwYEKw3gInSX0dpmCclA1qZozwVRQKNfFGStHGysoRUDZj9EeWN27ELl38gZ81AhrVpCMEdoof85q3lnHpgICVDGgXdL+ACzWXf/bb16NA0i0z00Gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oL/Mu/BvLomkqYAR78zTAd9zRov6nUDAw5dIfTzSYs=;
 b=bBYDYWCUpw9vBfPAxIahaVPddBaJZ3BhgOqXpeIs7ABx0+hrSCi3RXC1w6mFpJy36UdCPuTMs3q939sbMd3h1K8dUCwbkcx2h/jd7uPIigC0HjsZryKa1//s6jqDglN8aC/7zyE9fwTfFiuXAqsowGx/ST5SmDLhGOE7UBSYGe4=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5904.namprd04.prod.outlook.com (20.179.23.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 8 Aug 2019 10:15:50 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2%3]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 10:15:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jungseung Lee <js07.lee@samsung.com>,
        Chris Ball <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "js07.lee@gmail.com" <js07.lee@gmail.com>
Subject: RE: [PATCH v2] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Thread-Topic: [PATCH v2] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
Thread-Index: AQHVTcsK4Wn/xpA4VkOjMhWPFaGbv6bxCKRw
Date:   Thu, 8 Aug 2019 10:15:50 +0000
Message-ID: <MN2PR04MB6991C477ED6F7C35357B3558FCD70@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <CGME20190808092358epcas1p4076172a9e140332c0ddaa13fac18987b@epcas1p4.samsung.com>
 <20190808092341.3610-1-js07.lee@samsung.com>
In-Reply-To: <20190808092341.3610-1-js07.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77b2bc17-fc53-4288-68fb-08d71be96371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5904;
x-ms-traffictypediagnostic: MN2PR04MB5904:
x-microsoft-antispam-prvs: <MN2PR04MB5904DC26D35C787E7CB9AE0EFCD70@MN2PR04MB5904.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(199004)(189003)(476003)(6246003)(55016002)(26005)(2501003)(11346002)(2201001)(102836004)(229853002)(478600001)(5660300002)(6116002)(3846002)(86362001)(76176011)(486006)(2906002)(53936002)(9686003)(186003)(446003)(52536014)(74316002)(66446008)(66556008)(66476007)(64756008)(7736002)(6436002)(256004)(25786009)(305945005)(33656002)(99286004)(76116006)(6506007)(14454004)(110136005)(81166006)(81156014)(71200400001)(8936002)(8676002)(4744005)(71190400001)(66066001)(66946007)(7696005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5904;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fBwA9Wz/WlTkoZ8PrCtTe0Lhc1rvJ0Kj51u6MtRalf7gywoTOi+GzTgtBmQuc1DigM9+lNH5dtPIQhfPjZgHd9JOvfkT3mTni4M+90Bc9roZIh1Dd6R9LjoQNBAiIa4Belm9hF/ElWx+BL7A3vyZk3lnK1zAXDpjl/Ezk6qEADAV+FhZOLb8WpNemgjNFVTmVtRyjqQmoFzRAEI/PcBqWjD4b3iA6UmnlPdWrF41238eYfjjeo+5mInMVKRth3IOhi5+m7zJ4e7/8WUFhjmOxt4f5KYDQwbA37zWN4GaH+xpzyx4pP7aDKwjbU6r8vvTgWqdtfi8GwYm4RYO9dHm6tGD3zbZgBMUsd0cSIVScRb0s1E12OTpfxIprbmjUeKL1PPMp3+1GXSlTg8PstGeK6f7zIWfT5RMRFLae87SoJc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b2bc17-fc53-4288-68fb-08d71be96371
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 10:15:50.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IU0/4CuGl2netLBYD5hiswLTEtldaIAsPO2hc9aKt5c6a7jzOIhGf6IwpJxezH+Xo6Pur1F9UUSLrBJZUFxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5904
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gRGlzcGxheSBzZWN1cmUgcmVtb3ZhbCB0eXBlIHdoZW4gcHJpbnRpbmcgRXh0ZW5kZWQg
Q1NEDQo+IEV4YW1wbGU6DQo+IAkjIG1tYyBleHRjc2QgcmVhZCAvZGV2L21tY2JsazANCj4gCS4u
Lg0KPiAgICAgICAgIFNlY3VyZSBSZW1vdmFsIFR5cGUgW1NFQ1VSRV9SRU1PVkFMX1RZUEVdOiAw
eDM5DQo+ICAgICAgICAgIGluZm9ybWF0aW9uIGlzIGNvbmZpZ3VyZWQgdG8gYmUgcmVtb3ZlZCB1
c2luZyBhIHZlbmRvciBkZWZpbmVkDQo+ICAgICAgICAgIFN1cHBvcnRlZCBTZWN1cmUgUmVtb3Zh
bCBUeXBlOg0KPiAgICAgICAgICAgaW5mb3JtYXRpb24gcmVtb3ZlZCBieSBhbiBlcmFzZSBvZiB0
aGUgcGh5c2ljYWwgbWVtb3J5DQo+ICAgICAgICAgICBpbmZvcm1hdGlvbiByZW1vdmVkIHVzaW5n
IGEgdmVuZG9yIGRlZmluZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bmdzZXVuZyBMZWUgPGpz
MDcubGVlQHNhbXN1bmcuY29tPg0KUmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1h
bkB3ZGMuY29tPg0K
