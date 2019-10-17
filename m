Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761E8DAE7C
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfJQNd2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 09:33:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55057 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733089AbfJQNd2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 09:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571319208; x=1602855208;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pmXNpGqiw6A45/lhpVY1NpPWc7nQ5kamwLlcypj4Zf0=;
  b=kblWz6ZEf+v2gMiRGrennQAnojtKJ11W/WHm20Wp5y4jLcqqhCk2tK2X
   x5ThfhafDij4VGDPilL5GeX/kkr7uP4qpoOwBZTypRoxZw5Zs/BA54Aj0
   WtJVZnzNwjYUu7p5FTK834Ao+TawOppcOvjI66/vBB4R8aLTx4y1pGwES
   aP5nwxu27g0ds/Rx5nJ56bq8wnlntdoI8rSmUmA4Vc8PMiSnfrkj6v4j6
   EkYxlDWr65CafYZeV5sYqwCYZIlHsCzgRbIKm9f8vCrmn3C5LNc44CLnx
   k04IHEgp0SlSILx2c5QCQvjgzI67hFMQ527nV1CsDAuvmBJwQUIg1pkTO
   Q==;
IronPort-SDR: kexgp1so9gieMS/S3g1Gz2Q7Kypjy5ZJctN6sX4JT7H1oxTrwCxnuC3U3yCcwchrOkMsfe8E75
 mkz3j1r4YhBLTeweUUI+MJSA/LeQkML7gJqfUKiFYLWg+zTi5m4Mtww9Si/GlQts930AZ+tSij
 Ssg9yMSY2hInJm9W2GW1rHWx0zjD/yTzLA7Uw0ayrbslw4KkVna8RyUuP0yDSSHOQ458wQCTX/
 nS7KWb4yGZYh89jvfri+ZNwPblHZxJUPKYz4is2q21Ua3Rfn5GQQfSrmtkd9c28pQDpje++pso
 ZWE=
X-IronPort-AV: E=Sophos;i="5.67,307,1566835200"; 
   d="scan'208";a="125178922"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2019 21:33:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8VOEcWh5q2w8nLJDS+U3kmEvTsnAOgf7hNM+/cBaA9qqxNm0xnInDLtVDzClFATQhP5a+g4nn+Zm5TTq0l4cF9HamRBCg5AQDDARAISItX859UJITtrQ+IMy7TZ2GhKZjqBdbtBZJ4p4zHOGpBbraakl1b1bEUo4vL+AT1/ZYUfXNOuZ95NB8imTaPW6ZqJz+175eHkkFQkFIX02iNnO7z3qD/gYw+c7U6dZ+s8bNNjuw4Qts68kMSOUWmTGBtSI8m/LQ/9cvqqw6RyvpYdgmW4nc5WYZwA/ZPmp+QKQ+gjfg/QvWmr5tAWEd/mAi99BJdvd8q6DRuSX7k+mE1G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao8HKFqIypFYJZoC01le/JX8kVLlYq1fCtghpLkVbeA=;
 b=KfYl+2Nw43iaNwPp0lxUK7aU3SDWirwSnVa8dgWL0NS6OSSTj+gqB8+N8/LLVMXgMiusC8kUJOy/3dLqgVkbQj5EHQ0IvnOFmr/VC6Ak6reyIR5qcW5eVWoUvtJLXxtRbeWNTvzqMz3gz0QpVYFc3kWHmtcWl0YWQn3A3zp/IaIXx5r7QsJS9wmBX71TYiNVsrQW5CLGp3EhJbndcBLflbOnwxGhqwDfM9aV37oNXnjLtYHdahSUhVJaLEddUAMl4wSE+K4SARyKMi7g0iy3RKopxyy7Uf5XMqnA6+oJA9NsWA2Ld7NG1sPjM3WjCpX8NU4ohwaRSEg+cDlYDSWZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao8HKFqIypFYJZoC01le/JX8kVLlYq1fCtghpLkVbeA=;
 b=ayvavQAdIaJgBmzfo/zxSbHfcXYaZjUx12RXejPK+1NYPilyoJ9cYG9d420EnUJ5MaIokCzLxyDRwfP9uBBcQryHjhiGTtVcG0xd8sJykNfOZ+0PFqEskMwqHqu+QKW0OPi7j86WkmdBQ1TRYyU/lgmdPRkU9rFl1HiyvOOHOuo=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5758.namprd04.prod.outlook.com (20.179.22.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 13:33:26 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::cd55:cc47:e0ff:1604]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::cd55:cc47:e0ff:1604%6]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 13:33:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lars Pedersen <lapeddk@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Subject: RE: [PATCH 2/2] mmc-utils: Support for bkops start when manual
 background operation is used.
Thread-Topic: [PATCH 2/2] mmc-utils: Support for bkops start when manual
 background operation is used.
Thread-Index: AQHVhBMnvgcmJDyXV0uV+Pta2+oZCqde1FLg
Date:   Thu, 17 Oct 2019 13:33:25 +0000
Message-ID: <MN2PR04MB6991625FB8093E29605880F2FC6D0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191016111542.31358-1-laa@kamstrup.com>
 <20191016111542.31358-3-laa@kamstrup.com>
In-Reply-To: <20191016111542.31358-3-laa@kamstrup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8e0f5b9-decb-4ac2-9dd8-08d7530696d5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB5758:
x-microsoft-antispam-prvs: <MN2PR04MB57589D72ABC1F5413E9F2C70FC6D0@MN2PR04MB5758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(110136005)(2906002)(6116002)(3846002)(6436002)(316002)(558084003)(256004)(33656002)(446003)(229853002)(305945005)(7736002)(11346002)(486006)(71190400001)(71200400001)(476003)(478600001)(66066001)(25786009)(14454004)(74316002)(26005)(55016002)(9686003)(186003)(99286004)(5660300002)(52536014)(7696005)(76176011)(6506007)(102836004)(8936002)(2501003)(8676002)(81166006)(81156014)(76116006)(66946007)(66476007)(66446008)(66556008)(86362001)(64756008)(2201001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5758;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrncsu3k+ZTr++bbNvTtVlUYgNCKt/5M79tKK+kKd0OsVLUxxP2hUizLYaEJRMOvOJZWFhUna7+lOUJIv5bfGyYt1h9SqFU7hk3AfjULrAQp5PaEPkDOlhQZtRMsn8p13HeNzu5AcB/xeQBErsU7OqU78HUmRiFQiB4DISCZmzHzN5ZQOSFcHXBigZNmXlBmUlwVVkV4SlNqIfXG/siBpLoUyVKndVshi3P0Wf60YqlBp2ZB9+Ngs/K4qeBc8JYJdtMc1kVkHq/+4Yn1qIwWnWjexdNU7Mh+qAt6y87fujNCKWP60xGtC3OVaJXuuMUN5DK96Le4+vsQM59U8amt6PFW0spbAZEsR1t9V3ohyTxXI+n9esBLnYTDM/h8ekYoFmpMGFLkhxOxkXv1S+Dc4hOqaVcz55zNukDcIPRshXo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e0f5b9-decb-4ac2-9dd8-08d7530696d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:33:26.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xsd737k6JFqHxoZXXZlSvYakWeWxWbBiGoEnSsv8hkOoRHT/fQXdUFUd/I8FGOyBuscDX1P9FrGyyGEoB9ofpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5758
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
>=20
>=20
> From: Lars Pedersen <lapeddk@gmail.com>
Proper signing

>=20
> Add bkops start functionality when BKOPS_EN[0](MANUAL_EN) is set.


> +       ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_START, BKOPS_START);
You may want to allow to unset it as well,
otherwise you'll need to reset the platform to do so.

Thanks,
Avri
