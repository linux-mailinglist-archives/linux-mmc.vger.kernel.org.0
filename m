Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8DDADFB
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJQNNd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 09:13:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1495 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394360AbfJQNNc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 09:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571318045; x=1602854045;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AzA6/zIU0QxZYA7H6SmG5JSTvjzM0wXC1RJNPXkyIKk=;
  b=ivn3v53zyk+Iwfs2fN/nJWdECLUZI2U3OTRzBn1f5Bv3DSGmGi1l1d6M
   mQxV2G+J4TRtZ2Fs1OY1NwSntJfNuA2X+RgzDmDppI7OACOOw5fDRVdmr
   IFVFOxYOAvC7pb8SUD8pIXumAmwMEFR7eg4qLnyeIVPMM8RAupPOQv40B
   ykdvPy22HXhD3Y1nTcbf2reinkO6YGUKGhFcJ/DrtwXsDuyG/cOK1Tty/
   Kz2NNf+vXhNq9iH5hjqg2WbqaVeh9YmOHN1YSDk7wjK1vCVvCDPcEQ6HC
   E2J93W1rX7vfC7qNZaJaywd/NiRPM4DwLxe5KvwupobGaE8gk/hnMiSxf
   w==;
IronPort-SDR: 4he7Ll6olzGGb1yboxmz4pbY1BH05A9EDnujRGD0bwXRNnsfo/QfgDsoEEim3pHug2amul6tJQ
 m7OQymKM8zO/QS3pDCBJFFkoWeenAQm0KzkpssJHEkAPULmOpbHKOhMNFPYifWzKolPdQ33/YN
 1F3sHCta+XGCq83neGxwcKalYYQ9TebPaJ+IgqzvYfItUcb1+GBW/kNlav436jslrJ8bD6Ttue
 WxpKTwoi3Ej7P6mRQFsrZFFy+4ajpnezs5Ltpih9sdhhgZyLdCKgtOoHu5ExJX0MoE27wkJ5Wf
 qUs=
X-IronPort-AV: E=Sophos;i="5.67,307,1566835200"; 
   d="scan'208";a="221810307"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2019 21:14:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEQA1DwLMMYY7DcaQmJQh/d2PyuUZ/C8y4hCr8w2UcA2kA/o3kidJ4kTceG/RscZZVTAmDQHsfwnj/djL9vD+m6pw7peJqMn+5cwd0iTvw72bmfwzjjfbNmJIXOHIrkAKpIHWk95l6D9ec03y+ftubqx6Z1koT1+3QYGoZiRJWraGsaq6+Tn7mlPI07JHL6WAzVSSpWxi4/7OINPIaKwN6arC3b+aI7g2c2eNuiEC5xG/hcmtvwOevMUu2r6QVTY2KEWJlJfw2s2m00njJPyEEoY0XExqZrZTmj73DTW71hySYVRWsul1Pk7XRCub2tCIpbDQVEnQBHYwMOe+IO3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWDvHKVNSyrcGNqebDicVRNFAaSdyb3oEaftEvqFMDo=;
 b=i4+UMgE0N7tPs+TMrMe/9X1ypSekI88afogp+FTjvUI4U6T9JyJXUpl4QKhHxQs2D3x5a/Zswsr+lsv27c4/Ku3PvpzbyrhB6dZqxO3Iv+V9EcjwqvvlGfjBIgo+nHgwYpT5Dxks5SWo580MuZ8kQMCqMkVlVMNzoK5i4VBDNdCePdJnUE238fpDR9kg/FHOJ40sFMh5kxATSSuSmC7Ernl8x/CD/Bf2WzMYW26GgOCJfD5HYOWiDJWZQA9WHIn0xjJHN8Qsqs6HOIquffvCNr/IYA8Pn8zhfAZRO6gc7d3iP+XPRUbSjVUjyQZgiP8y/pZgkNVdfhgpWDbcKOK62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWDvHKVNSyrcGNqebDicVRNFAaSdyb3oEaftEvqFMDo=;
 b=iOzcOQQmGaahJPo2bhwPu7dMZCOcKPl32jCEq9Da1gUnzQo4VOsTOgNzFSUstykytDCfIyZ6JtEoK9bibctl1NX1arcIWUgHp6d4gJ5qq5kJC4PhNoa++qWjUsJvMVvLWtcOapONKT6gJz2QsOdzuuMRV+BPEm1IX9zuhzG1qY8=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5742.namprd04.prod.outlook.com (20.179.21.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 13:13:30 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::cd55:cc47:e0ff:1604]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::cd55:cc47:e0ff:1604%6]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 13:13:30 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lars Pedersen <lapeddk@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "michael.heimpold@i2se.com" <michael.heimpold@i2se.com>
Subject: RE: [PATCH 1/2] mmc-utils: Support MANUAL_EN and AUTO_EN in BKOPS_EN
 register
Thread-Topic: [PATCH 1/2] mmc-utils: Support MANUAL_EN and AUTO_EN in BKOPS_EN
 register
Thread-Index: AQHVhBMlsBK/V/iuvkagh6l4yb1SmadezZgg
Date:   Thu, 17 Oct 2019 13:13:29 +0000
Message-ID: <MN2PR04MB69917A18907B5594F5CD9542FC6D0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191016111542.31358-1-laa@kamstrup.com>
 <20191016111542.31358-2-laa@kamstrup.com>
In-Reply-To: <20191016111542.31358-2-laa@kamstrup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70a9480a-09b0-4c97-de4e-08d75303cddf
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB5742:
x-microsoft-antispam-prvs: <MN2PR04MB5742EAEF685E9C8D133ACB9CFC6D0@MN2PR04MB5742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(55016002)(74316002)(33656002)(305945005)(86362001)(486006)(3846002)(6436002)(229853002)(7736002)(6116002)(2201001)(66066001)(71190400001)(71200400001)(81156014)(8936002)(81166006)(8676002)(256004)(76116006)(66946007)(6506007)(476003)(66446008)(64756008)(66556008)(66476007)(11346002)(316002)(6246003)(446003)(110136005)(7696005)(52536014)(76176011)(478600001)(14454004)(102836004)(5660300002)(99286004)(25786009)(26005)(2906002)(9686003)(186003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5742;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ol152XFmza8pZKrihhYxwYLE+xEpFa/bQpW3rIkRtmTh5Hu6CP2JYZ6w1T4dJoH1xuaTVSA/HGkV1YIsRyqd1u84Kv5YQxfMIogCBbaCG1Auimluf/SZTpsiYGuGjvcKS8rbkhf1R3Npu6CYM8B/92zYoBxwOXvkNvLFP7jUBke1kFlwMaSg9whGqn8pwefD542eNC/T0uuWCjrujOrnXeDjD8H6bFGVi0iKEhC4sofHPEqc2ltlsx0Sb/CkY9IppBUit0LkuyRSj5t33Qgzudd+AzlgA6YFbQt8Eq0JjK4pg62acTZ94Z5hSN8qglrBTPRW0lmFdMMuxb9JyGOGhMYzN9Ch/WWQe5hL1bLenJS4bLuSlvYa0qVhgOdAtE4qGquH00OrYNIrBXff1Mr3e6b92AspP6w9NnNd/HSXMaQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a9480a-09b0-4c97-de4e-08d75303cddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:13:29.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gM7N9/SPhJu0D7feHds7FC5ugwC+s1xeOAwHc6chPvLeWh3Y9tjaWuJxY9rcgj6ijd+LBbnLwWtbMYZyBLdBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5742
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

>=20
> From: Lars Pedersen <lapeddk@gmail.com>
Please sign your patch (use -s when running git commit)

>=20
> The BKOPS_EN register in eMMC 5.1 now has two fields AUTO_EN and
> MANUAL_EN.
It was already in 5.0


> +       { do_write_bkops_auto_en, -2,
> +         "bkops auto", "<mode> <device>\n"
> +               "Enable/disable eMMC BKOPS AUTO_EN feature on <device>.\n=
The
> device may perform background operations while not servicing the host.\n"
> +               "NOTE!  Only supported in eMMC-5.1 and
> + MANUAL_EN(BKOPS_EN[0]) must not be set",
>           NULL
Although there is not much sense of setting those both,
I am not sure that the manual and auto bits are mutually exclusive.
Will ask around.

>         },
>         { do_hwreset_en, -1,
> @@ -467,7 +473,7 @@ static int parse_args(int argc, char **argv,
>                         matchcmd->verb, matchcmd->nargs);
>                         return -2;
>         }
> -
> +
Not belong to this patch

> +int do_write_bkops_auto_en(int nargs, char **argv) {
> +       __u8 ext_csd[512], value =3D 0;
> +       int fd, ret;
> +       char *device;
> +       char *mode;
> +
> +       if (nargs !=3D 3) {
> +              fprintf(stderr, "Usage: mmc bkops auto enable/disable
> </path/to/mmcblkX>\n");
> +              exit(1);
> +       }
> +
> +       mode =3D argv[1];
> +       device =3D argv[2];
> +
> +       fd =3D open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               exit(1);
> +       }
> +
> +       if (ext_csd[EXT_CSD_REV] !=3D EXT_CSD_REV_V5_1) {
ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0

> +               fprintf(stderr, "%s doesn't support eMMC 5.1\n", device);
> +               exit(1);
> +       }
> +
> +       if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
This is obsolete in 5.1 and need not be checked.

> +               fprintf(stderr, "%s doesn't support BKOPS\n", device);
> +               exit(1);
> +       }
> +
> +       if ((ext_csd[EXT_CSD_BKOPS_EN] & 0x1)) {
Again - not sure about that.
Look in the kerne's driver, its checks for both options.

> +               fprintf(stderr, "%s manual BKOPS already enabled.\n", dev=
ice);
> +               exit(1);
> +       }
> +
> +       if (strcmp(mode, "enable") =3D=3D 0) {
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_ENABLE_AUTO_SET);
> +       } else if (strcmp(mode, "disable") =3D=3D 0) {
> +               ret =3D write_extcsd_value(fd, EXT_CSD_BKOPS_EN,
> BKOPS_ENABLE_AUTO_CLR);
> +       } else {
> +               fprintf(stderr, "%s invalid mode for BKOPS_EN AUTO_EN req=
uested:
> %s. Valid options: enable or disable\n", mode, device);
> +               exit(1);
> +       }
> +

I even think, as we are not so strictly obliged to zero API changes,
Maybe just change the api to do_write_bkops_en(), and simply allow to set 1=
, 2, or 3 to that register?


Thanks,
Avri
