Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF10EE06D
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 13:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDMua (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 07:50:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40836 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDMua (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 07:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572871831; x=1604407831;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Qa0GLhjsFOHcJkHii38de9x107Nz8VfndXo3Fj7RHAw=;
  b=mtsCKqUmceBAppLDAd8QTdu+NURrUCTxRmSqX+VCZzS40uKduLeeo42A
   YqovHYYxOwE+gdvCWCcWzviZoq88rsxkS1mmqIRb+/2qn/b7wQVjg9nt1
   X1xpMBD3G4wa0A6B09yhIop4mrr4aNW1dUBzSLKONs80FERmU5qdmpGYo
   adig0Awln46cbwiID4IrYghCg0L1kryZGb+SFaxQDDY8DtCpLyzRpuqbM
   TMbAY624XQ49GprxR7HeUPOJlLSyRfF11no0Fj/OrPe5OpRjpdQvc/ro2
   xEGvQoUJkscGwlnimxbfs8a8Khj1Cf5qPXilUnQelehwpT3d7KWzibbXF
   A==;
IronPort-SDR: QHolwQinZAG7uJpM4BOwThZHkdYWdFTKb5n3uulmHuKF8XD8YOnjvFi1q4vS+S221e+0XdJk+q
 zOuChR95YfDeOLhVnaxmRaOh+5NgXq/bYFBabb/yqrl2l+VYlWCBOgYlzbkIADf3NvL7UiXT1+
 LSVzv+xRSUljUweFTWxunqKiCZ6coED2xEG7B0B2sh/frSbhdVVwIY2mDIBpgyz2JhiCz9bEWU
 8wm09Rqlj7k1IOMvFGj7cMPM6eopoorVuxCt1OAOnPSFgLOhAFmMj/mmRzMPsptpfd9qgmrvCw
 ajI=
X-IronPort-AV: E=Sophos;i="5.68,267,1569254400"; 
   d="scan'208";a="126476054"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 20:50:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUdHaZ0KtA63jVrQG1YCGxw9YEEXtnSH/fXR9aCcPHn1OYriZLFirlOXsm4Z2pAmq7oh3rRBuJq51fsF/HsX7MgLtTUaoAuHVqU95OdSuGU8HYWW725Tw/5GL8FePtDAqLnQbPd7UkL7JyGKNu35k1ENzh8FXfIJfXWUx61G5w7uQy7b43lH6DG+q2qcdjTZRt3vmKXfpP6vdGtJA1RQT0rLbBV7ge82ofFkex8xKMfdk/4I/+vzXUcXHZMC1N9yMjHlHy3CqvNYStLAOPD9cnJB3OWPKvPUR9z8eZnuAmELDcQmN6v6AatFWEuyGFfdAxSSCzv/2Z4/hA+XtrSC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa0GLhjsFOHcJkHii38de9x107Nz8VfndXo3Fj7RHAw=;
 b=B/5XdOKCrJXndmyuRSoGL0DJro7q719KD8FjqAb+QH8x3XGdb8XNk2vyGG89ci0CjU/xOz7wWB8uCfHG4Axa+A5Awesk19D/ONsrE9d7/tsSJYVv6uozNHiY1cCrHwxPLsX9zWxXkq98xDg7atTBLrSJiYp4JNcFl9vZGKa7+DY2zYQDMYvDQ0uFCicb65yyQ3Bd0S6k5JtMNZ6L1aBum5o/76QIgu2jSTeeoRKlhy6Z7TBwTmYE8rZY3fMD+PKZTJ/91AKNqVU7aAXbyCejh5ZTMfSH1ZsTNqut+ZGaZTTgFC5xxwtz54ggTPF6ma0S2mNwfz/+mP5tDIzY+7e0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa0GLhjsFOHcJkHii38de9x107Nz8VfndXo3Fj7RHAw=;
 b=vOCIm6pdhbPNIs3FPPPp43tGV0KGY0G4MkQkJB1f2tlBC5Q1b65apq/vbttrb39OYjx7msv3ZhMmWIQrxZqo2n7hnAqnQkWMlfeobszYJOtrSdyA0gfnEwI2ZgIH2cTplmRJ2V/PHbpzBieM5cBCWjj4XEeqLoizONSRNJnLTzU=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5663.namprd04.prod.outlook.com (20.179.22.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 12:50:27 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 12:50:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lars Pedersen <lapeddk@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Subject: RE: [PATCH v2 1/1] mmc-utils: Support MANUAL_EN and AUTO_EN in
 BKOPS_EN register
Thread-Topic: [PATCH v2 1/1] mmc-utils: Support MANUAL_EN and AUTO_EN in
 BKOPS_EN register
Thread-Index: AQHVinW66NrDl4X30kyXWrFGVIBfs6d7B0Tw
Date:   Mon, 4 Nov 2019 12:50:27 +0000
Message-ID: <MN2PR04MB6991A80C5592DBB67AA0F18FFC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191024141634.19287-1-lapeddk@gmail.com>
 <20191024141634.19287-2-lapeddk@gmail.com>
In-Reply-To: <20191024141634.19287-2-lapeddk@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5879225-d4e8-4213-dafd-08d761259158
x-ms-traffictypediagnostic: MN2PR04MB5663:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR04MB5663E44FB67EEDB7DD7CACD4FC7F0@MN2PR04MB5663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(558084003)(486006)(6116002)(8936002)(3846002)(66066001)(71200400001)(71190400001)(9686003)(52536014)(76176011)(66946007)(55016002)(6306002)(14454004)(6436002)(26005)(186003)(33656002)(229853002)(76116006)(86362001)(256004)(64756008)(66556008)(6506007)(102836004)(446003)(11346002)(2906002)(74316002)(99286004)(6246003)(2501003)(305945005)(7736002)(7696005)(478600001)(66446008)(66476007)(8676002)(476003)(81156014)(81166006)(110136005)(25786009)(966005)(2201001)(316002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5663;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhqRc53/AFN9uuUWC23Eea7djRDAv3PG5j40xnu6pX8TJgLyn2COgew13O/McVpKWN+b5NhiBWezRRyWAnW7xSWNeeW3rrhXNf2f6u4WvaJhcrZDozJOJkK8D/mWcW+BtLt21e5j8C+oQHZ/a0SCVig8m5Ff/DUZln0WAUv9g60IhpIMYZj1NHwFfuj536jQwFGL002LCmg6PALtmp4Yf89VKlAtiU41StHA5foC9BQaY7dKaywJC1pykeeEYgd5koBMsIIBcNER/sFYJOdxG5KNDkKUZfhRWsxA6LMG9CyAtkmZjD+0GQFUXnS0VlFtdlNN/dNA4/8ZNeo7I+dYUAjE/odT5XK6WkUyUqgvGzzG8eAffYDUQGNZ5ElBKUGpTFF0JmoytyCpyaOfEK2aPi4K/Cr8Gyqx4L2yEfEoyuszvgQcsIFM1XdbseQ0iZO7PpH8OK12ezSteC73SypdYnSj5mpCDl+LvmkE/oJx1vU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5879225-d4e8-4213-dafd-08d761259158
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 12:50:27.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n+LSrq+kRkKSW9KzbKrBThyH/KHO0Z47G94Qnum3USAerVpPkI/Yk9PPgE29Ht2bwcltYQirtaUi1p5ppEL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5663
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Lars,

>=20
> The BKOPS_EN register in eMMC 5.1 now has two fields AUTO_EN and
> MANUAL_EN.
>=20
> Signed-off-by: Lars Pedersen <lapeddk@gmail.com>
You didn't responded to my previous comments -=20
See https://www.spinics.net/lists/linux-mmc/msg56320.html
Also, The 0/1 is no longer needed.

Thanks,
Avri
