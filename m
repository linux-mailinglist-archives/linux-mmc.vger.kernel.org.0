Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7CF8E8F
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLL2m (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 06:28:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14017 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLL2m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 06:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573558121; x=1605094121;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YnDbp/+U9PGcnjQkeG30kOI0/QXGVpN2li4hnTTfKBc=;
  b=SQoxrehnvBv1gLXX4ribhfKelpDKW2dYw+/waET0mgWwgh2NgGa0+OQr
   IAzYgRdka9raa4xZTaxe5XnLyEj5R2BTfxMfHPRi4NKki+3Eg4/8BpSuR
   jo1wcr49RN0gviXKMfpuaXjLiJBXYQhrrjROg7DhCck745hl9hDXDK4n0
   q0TvgpeMchon7pqNh9vmtt0ohbpO/FCQJ7quwgm9XsrSMcpNs9ogevL7+
   0GOgGI4DZS+qqd38+pxweB147yT/akTectys3cvSq7ZEkMNsAupBy4Rd2
   k2qQjofggHvdv52l9UmjJTOMHy8znxW3thNXSRxIMb1k8tvUDAylsPa3k
   A==;
IronPort-SDR: 19f8MDPgbZk+iqE52uDRyXUBbnOBsOzavkXS7xm+BhL9qV3/hD2kPTqaZb5yzkUz9RFoMeS7l2
 vVxbenjDZe3ZmuM3GfC89ljLH04sbWXUwfFtN5m/t4i/3gpG0VMy8EN1pNwYgAxxBQWmp04E+P
 lzJrj2ZZlUs3x5UNFgDepIQcDcCI+U6Gsf7gEv0HEu66ze5+PCsDXE/2xwj4lvBGNSTBwmfRM6
 pwDtMhHWvSvgawgdUTuEcVMhGbnGvu3CDbpkGEHlgpXQvoRhyQ5B3cbcX5G53KkPqEwpfvnV1L
 RAM=
X-IronPort-AV: E=Sophos;i="5.68,296,1569254400"; 
   d="scan'208";a="122745035"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 19:26:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXVEa53hIosyY0uOveYmlsMuz83xNQeFUn1xUZIbVyR6gV2j0SnRmcPkVcHXD/ZrYjXVcpSix3rJo6OGTofjYzoj7anY+3qvqpff73Fzb0S29JFAqS/uljGgt+SA9+53lp1S6it3Tjl7LIeqKZ6w/JGoo4LBqcvDnaDp130dMoFxAv3ymyTiKKgKNiaBGqnMJxwfL5JxPgCJh60csuRWhESeIypfdq9Uf5Rf62rmpddh36hk1gUjUiKjFnmN3SvC7FE+rIpXlI6fHNgjfqC93/1IUmV5Md2ujig4ei6oG9EUyO0BCjT53L7wmEliUvWlBB+wbnFmVG0YgQBI2eV7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WleKgJX/PDyqHX/LepDO9pdOODcbPkccfhN6uSBC7aI=;
 b=PVdhaP8sKXBYkj81UAtuQy3uHWkQd6XssR6Ku7mHp7/eFQrHMN1EHamkTvvE6dp0kXSFMMZWs/rrLuNcdwuu+ogi5Hzp4Ugb4/kObBdEbBxdLwfKfGrvanUjVhpe3u9yPai8Uigno+wWNGOdYezxClOTkrllrsWd22ibFmLGwIqAyCd6j/ica9Za3Vg4oXwCj2KTV5w22IJYgPx09Ub4ExvdN/tT2L4zN45rbGa+Qjl/aTeGX54b77ktULV1lBYung3RBTHT3GAwGSBuEcadudjb2po+LAYEGCkJxm9t9DPKhSo09y+L51+6OcgHet4Lt6CRPzyjgkzPq8Oxm9Ku5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WleKgJX/PDyqHX/LepDO9pdOODcbPkccfhN6uSBC7aI=;
 b=rrvuFAUOwEuzPz+ZUQXhjodVu6fXL/LGiaHRbhrZxgbdKiSsU9i6o7pr6lkawhZ1b395BCJZ0dtha+V9Bw1WCWATK242Qry56tmU2e3VNP7hgRX3Wgmql7H5atYFI1i2Atx9hIBDmWit8wE6XhQHB2x6q7LRgFxlJKdw+Tl5PJo=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6317.namprd04.prod.outlook.com (52.132.170.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:26:49 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:26:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lars Pedersen <lapeddk@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Subject: RE: [PATCH v3] mmc-utils: Add AUTO_EN support in the BKOPS_EN
Thread-Topic: [PATCH v3] mmc-utils: Add AUTO_EN support in the BKOPS_EN
Thread-Index: AQHVmH9mz6RGDfDBMEiPITk6bv1HAKeHZfvA
Date:   Tue, 12 Nov 2019 11:26:49 +0000
Message-ID: <MN2PR04MB6991723BC215D74DAF6D1E30FC770@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191111110051.16490-1-lapeddk@gmail.com>
In-Reply-To: <20191111110051.16490-1-lapeddk@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d604501d-1c55-49f2-2cc7-08d7676335b5
x-ms-traffictypediagnostic: MN2PR04MB6317:
x-microsoft-antispam-prvs: <MN2PR04MB63175E8D262FA5650C56170DFC770@MN2PR04MB6317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:232;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(9686003)(478600001)(229853002)(14454004)(6436002)(316002)(8676002)(256004)(81156014)(55016002)(81166006)(3846002)(6116002)(6246003)(86362001)(8936002)(186003)(7736002)(2501003)(52536014)(476003)(446003)(76116006)(26005)(99286004)(74316002)(486006)(66556008)(64756008)(66446008)(2906002)(66476007)(33656002)(71190400001)(71200400001)(102836004)(76176011)(4744005)(25786009)(66066001)(2201001)(6506007)(66946007)(5660300002)(7696005)(11346002)(305945005)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6317;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEcYriUkoNvpM9jx9nIBHC62AUsXwHMiaYm9fjeiwRt06fUlBilYBanbmgK1BE1pgRqL/HKEY+6PmxBTEMC3TKp3+b4cDwSW0gupzrwNRYOz1bl1Y8AAZeQvzCs5C2vK1JnJhNTrehMjwn4/j0T6AOCEkSzbailwEjfdjMERBuKnFP3dQUO5VGXwtOK94tqeoNxiAy22jjJHjevlnclMQgAzOn8D0H45HmefMVdGpugRVh9AxGmUkPQ9fHkpB20c6agzEjcgsz9dgHP2VE6Wb8sPjmTI+Q51Z2RsuQS/XpUstoG/gzVePjAIwcr12uqMGxx6Gm4msnjXZI5kHRRtdQB0rz/eE7nrJZ8GwH8qWn11tkKKjMuW/9ruZJ/85zA7kocIkk7wtfGyQUULZi7asEpbeZKP1GDxnOhpmn+phgP45Qz9qUpG5OYmIBQBJPO+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d604501d-1c55-49f2-2cc7-08d7676335b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:26:49.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EycdCTB/At0YpvkEMy6BhAn8HKZA3Yr1jXVnbrXaUtUWlzkPJ6gPQp8ut5vPpPU6Z4iZB6mfBCPf1lUS9LLehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6317
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

>=20
> Signed-off-by: Lars Pedersen <lapeddk@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -734,13 +734,15 @@ int do_write_bkops_en(int nargs, char **argv)
>         __u8 ext_csd[512], value =3D 0;
>         int fd, ret;
>         char *device;
> +       char *en_type;
A small nit - preferably do your strcmp and assign some type variable,
But that's fine as well.

Thanks,
Avri

