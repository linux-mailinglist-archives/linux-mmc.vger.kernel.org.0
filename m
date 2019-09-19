Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED53B767E
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 11:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfISJlI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 05:41:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61504 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388817AbfISJlI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 05:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568886111; x=1600422111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NGFwqiA+644yaZMeMaSoCVRMQGffW2YEJXLz0lwCKEU=;
  b=Rxd4siKDum+oPGpOyQL/XZIE4jWSF5M1dL6J+w6HFSl/oP4M3tRLaETe
   Rwv+D6BdZqxysZQQtUdyRHJdZY1xwNbAzW1CR5NZruo+izaHpCKDFVKNi
   2jjMlicslVKxxOdcUsz58db6YnYlJHPIE+QkNula2+o7V52pP3SVxaDgQ
   GRnp5Q7IetTd4yqtxB/hyKEDmJupxVZQiB2OY9OsVwStDOZnOPooyzQNh
   vU+/aR6Tte96a9uDw5BtUCdgsBUCAwyNvT4yLWKbTh6BXblW1RvhcZEGM
   ldInpsdP5fjsLhUMPh/E7mDi8anlXmbkooTNv2Vumh4VkxwMLqQLkjKKN
   g==;
IronPort-SDR: Xsxg8lRxGAGtofL8RhiuHo79sR0vijYDstfQZTgjt6Nrr0a7K8dunb6deRu92TBxZbBEBbcSii
 nrQCRe8vB6wfG/FtRuWJ9l0sx+gb6kelcHmssqv/AM9TqBhVBnrcwK98lg6N6+83HmGxg8MYdp
 RH8mNFnqX55GIPXBGvJg04mW10PWNcIUibX6kYh7lYm0aQpGtgLYWLuQ25WN7ZTq7YSz24WVEE
 MIUqBWUmZ0KR7hM1hrxdJ1q4OdWQz55mtORNXjciuxMPnbH+BEj4ix77SH92Q4L2NFMRJpH5nb
 d9s=
X-IronPort-AV: E=Sophos;i="5.64,523,1559491200"; 
   d="scan'208";a="219428424"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 17:41:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUbMoPSzufm8jGdE5FNUdiLbFD75ebwBiES9eQgZnsEQoV9OuWONF4Sj4VP3DH2GcfqlZ9fEIcgrLZZRyT6JxNB5Eoppa+ha5I25ao0H4db6VNIOP9JLrQULEqKCDLpBTt0dNH5RXSDWBkrOZqDrgKhCtG1BF1cd3uTduTzFcaGgt3yzlW6dD4E9QsI8PSIur2M/yU4qi/XJc/GoLkR0QVQTQm3Z+0AOyY/Rv2Vqq9Yr/psNBXxxabj6myq6HuOD32MdJ31xIFNMuwJXyVMrRo2x+vckzjae+t05RzyTD7IsVITOSFUcGVNFzjmR3ocZgLjf5NYeuVONeT4AP0u2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLdVohlgV0mmqgx4RieLmtSX+KZHMZCD5CkkiWgYPMs=;
 b=NJKASKgwgcgsrv2P6qGbpM+VzCa67aHsVzearypCjFSNPyLNgi4mvlef7HgPLdFXXg9oSTyLhgjTGJ6nBLrUG75BUP+5aJPTFm6HaTP+xQ4SfMXh3SDpBiF9O0Wny9E+f3DGJHW6Xa01ZYR//BJcQ7OUyphnqkqBNHJ14AqYsJKPoO2A93FHaociBGOPg5Q0zw4AlXqOsJc8SsJODdBaZ2gTqI9WmJuO+6300Wi+AoHWRmxxHGuzf79CsvtaGf8QZage3MEc6453XpDtVQLPFa7fX2fFL/xJX/dNDGtk/Kt4HVaSyqyADQj1HYBxGb6Xu2F8RLlrLvacZ4IPduSC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLdVohlgV0mmqgx4RieLmtSX+KZHMZCD5CkkiWgYPMs=;
 b=iSaZ7kEhuf1gGcOy6ROG+e7RA9v2gyibiU1dlxh7m+8ntJYh91602dZdPBMc0kMKyCzsFJaM/9cFLs4fuG+MdlL6DYE6KD3wIcdHsPb9ZHBh1isGUeFs/b9H1yeD/bWOoMORIMs0n0tskkqpxXcg1aaaA/fE8dn0p0DaMwyfvTQ=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 09:41:06 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 09:41:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Michael Heimpold <mhei@heimpold.de>,
        "chris@printf.net" <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Thread-Topic: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
Thread-Index: AQHVaa67ZkDrfKUAHUuBW2wff6DItKcyx9ow
Date:   Thu, 19 Sep 2019 09:41:06 +0000
Message-ID: <MN2PR04MB6991CE61681D33F1F7E76ADAFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190912210509.19816-1-mhei@heimpold.de>
In-Reply-To: <20190912210509.19816-1-mhei@heimpold.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bf98f05-63c9-49d4-74a9-08d73ce57e72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6061;
x-ms-traffictypediagnostic: MN2PR04MB6061:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR04MB606163F3F134A51CD2FEAF32FC890@MN2PR04MB6061.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(26005)(6306002)(14454004)(966005)(478600001)(9686003)(4326008)(55016002)(74316002)(7736002)(256004)(6436002)(25786009)(71190400001)(6246003)(71200400001)(305945005)(5660300002)(64756008)(66446008)(66476007)(76116006)(8936002)(446003)(476003)(11346002)(8676002)(2501003)(33656002)(66556008)(66946007)(186003)(229853002)(81156014)(81166006)(86362001)(102836004)(99286004)(76176011)(7696005)(66066001)(6506007)(316002)(486006)(2906002)(52536014)(3846002)(110136005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6061;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VhP9bgCJmD50elAx+h4czRrjlThue+XaZsDrpwRqbVqhit5rNULtT5V6f6SzbQ1bSJBvqFeW1hW/BIIF+1UrY3V3Orz0ipAksRorJZbUeh3mNy1QsNput+gKbB07ZkDj5XgoYTv3RP12wKqTvgE3uP/RWUiTYQEWsOu66B8f2TrAsNq/Ieqhyr4yUOawTrBGBo0eHF26ATWG6o7cggdPPdJBr03BOFfFUyKDZW0s1URt+3852Bp3D+2MvsnbGt1I0vg13PEAuKsX+8QFx4EitlVEZN1NTVkzTOSdDnJ6vQqy362vjltr8fh4ijiVet6PdveIs8++msmjfIiocYBLydAwBAwXBQA90hTzm+xlpMtXzPVjyj9e3c6TjJduQ/q2s1chmWtQa3PMRIDDDgsS6IFQ+T1qKc8TA25WJ9aKx+c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf98f05-63c9-49d4-74a9-08d73ce57e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 09:41:06.1821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehz5ro42Bf5YiWcQro/JCjEuNsOBoBo8BIUAha+oTjfJm5rahD27Kw9MHxq4O7m7DOEBjkA4Pzfvt+QxwPWOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6061
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf/Adrian,

As Chris is less responsive in the past few years,
We might want to follow the scsi ML practice with regard to the ufs driver:
Add several reviewers while Martin is pulling the patches.

It is working quite well since then.

Is this something that you might consider?

Thanks,
Avri

>=20
>=20
> This series bundles several small fixes and enhancements I stumbled over
> during short testing around one year ago.
>=20
> The initial sent v1 got a review by Avri, but was not applied (yet).
>=20
> I'm resending this v2 with the hope, that there is now some more interest=
.
>=20
> I added his Reviewed-by, no other technical changes.
>=20
> It can also be found in my Github tree:
> https://github.com/mhei/mmc-utils/tree/fixes-enh
>=20
> Michael Heimpold (5):
>   Check calloc's return value before using the pointer
>   Cleanup memory in error case
>   Fix parsing of character in to_binstr()
>   Optimize to_binstr() function
>   Add eMMC vendor Micron to table
>=20
>  lsmmc.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> --
> 2.17.1

