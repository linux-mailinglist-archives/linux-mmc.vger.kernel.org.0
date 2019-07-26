Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD657673B
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZNWF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 26 Jul 2019 09:22:05 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59870 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfGZNWF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2019 09:22:05 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QD7I4F020000;
        Fri, 26 Jul 2019 06:22:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=9ahKdMlwpZ+HLMkl/yxVXlPaCMIHUtpXXLxdNGfFAks=;
 b=pRo5fyAAjDAHrhiuhUR4QUzx6iGOzoLGj3gIpmD3PO/4flxJlsZrDIiQdeMP+66q+xBW
 OFullmyzzasjNc8EewOSpVr2DrrKSiZul9YbKNaokMD829cEleYM3SFkzAU1bo2OnVR0
 ++jZPydYYMi76JsBe4PdX7F4kHbnwTyEVTZQFjEhgR7VM5GRc+eWn7QFMXimSa/bQ/KP
 9zq2eAloLSbEUqw0eGC7a05JGAbgTvugrmHdUlH9zt9fOaX2ANhv9kcz5fcf9DRgxLiy
 bTP+AxHAN3Hp57UdwU2kJZjiz0d4nZ/l/o5lWbXuIZ36CfS6BPAY2T7amUncSxuOXT+o eA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256a1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 06:22:02 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 06:22:01 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.56) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Jul 2019 06:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIO5I78F536aPvNVuC4OpiiWC46fU5hT28HqFPJF/7KZXz06r11VDyh5R7zbM/8ml7WctalE/4BIkIp1+FwkKY3Nzm7xhBsYsELpPOBngHiidMTsD8jIhi6UGyiQ24muLgi/eTbPiI/I30QlMs3yamFXzYv+XSCcVdXYybTOU8AcqAud56Gm3DvCnJtFVFaiqr2yHJ6s9xNyxW8a16lTXNm5llJlqQf5FlcF1HiGIHt4zaB1qEE6jVDCGhxqABEUHlHC5mlv9QPTqmzO5l4QwsIYBjvXIsZSovLxzl3wfntCD8WeQUa4jYqCcjCSELW844vIoKFXiWkiQ0uOP6XLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ahKdMlwpZ+HLMkl/yxVXlPaCMIHUtpXXLxdNGfFAks=;
 b=n3YuqAyrsqmYMz4Pz6OalOYXlxL5RqNFm2udlq0eFZkxS8N6kq2vL2tErd8/UoXzxkYuG1V9aIZRjcMAAkoaT3k3rQQvG7otvnbwNfMxSwaG1B2UcSAWeeq+D6RvH5ZA+x+L60GcfMq/UYLd//ig3d4X1RKHssfPwaoLd/N4QTKmte7Ef3UUNYrS7fmRINwLhXCmVB0htomney6rHm/c9wjQIYEcTVIu94Hgcw5fmNOyvAXmzQXvLd/APA0F8yq0/++Xg4s05YnwKqpyE0JINof7G5xfgAeG6a0JB4Kccm5eXfitQ+Oa2IPIwx1SN3zsCFf0ZJSwHxSai28oiQ7PNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ahKdMlwpZ+HLMkl/yxVXlPaCMIHUtpXXLxdNGfFAks=;
 b=s+8TbNtBUyvp32tQ/HvvlxJp6S4B5WWxFH+KfgNQodxphEaF942tjPiAJCrSwpsKcP0lQZ3UEpX0auTztVlLrwGsUiaZUaZRXT1GgL6TmfsRm+UdW3T1vD1PTr/IgbkH0z0CQj4VGdGgnHLuA43NL3tLI/3ZJxDh6X8gZoWVLjA=
Received: from BL0PR18MB2339.namprd18.prod.outlook.com (52.132.10.160) by
 BL0PR18MB2083.namprd18.prod.outlook.com (52.132.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Fri, 26 Jul 2019 13:21:56 +0000
Received: from BL0PR18MB2339.namprd18.prod.outlook.com
 ([fe80::d0a5:792f:f199:c3a9]) by BL0PR18MB2339.namprd18.prod.outlook.com
 ([fe80::d0a5:792f:f199:c3a9%4]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 13:21:56 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Kevin Hao <haokexin@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jan Glauber <jglauber@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: cavium: Fix two calltraces when the
Thread-Topic: [PATCH 0/2] mmc: cavium: Fix two calltraces when the
Thread-Index: AQHVQ7UYl8VK3f/3jUqrR9QPmHdeTA==
Date:   Fri, 26 Jul 2019 13:21:56 +0000
Message-ID: <20190726132149.GA19047@hc>
References: <20190726023049.27055-1-haokexin@gmail.com>
In-Reply-To: <20190726023049.27055-1-haokexin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::20) To BL0PR18MB2339.namprd18.prod.outlook.com
 (2603:10b6:207:4c::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.67.136.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99ab5984-524c-499e-ff81-08d711cc3b58
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR18MB2083;
x-ms-traffictypediagnostic: BL0PR18MB2083:
x-microsoft-antispam-prvs: <BL0PR18MB208371669F3459B621C670F3D8C00@BL0PR18MB2083.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(366004)(376002)(39860400002)(396003)(346002)(52314003)(199004)(189003)(14454004)(486006)(54906003)(6916009)(9686003)(316002)(6512007)(53936002)(6486002)(6436002)(86362001)(3846002)(6116002)(33716001)(2906002)(1411001)(99286004)(256004)(14444005)(8676002)(11346002)(476003)(446003)(76176011)(52116002)(102836004)(478600001)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(186003)(26005)(71200400001)(71190400001)(25786009)(386003)(6506007)(4744005)(66066001)(81156014)(4326008)(8936002)(81166006)(33656002)(305945005)(7736002)(68736007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2083;H:BL0PR18MB2339.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0m4Wp6txSrda6MukuyjdG7+kmLc8cnIOO/AYngdszGfz6sdGGHnCGaM7oNjN7PgD/bR3idbmipvUsplpywm50Sx2it0o6Q0wXB0xQ0827mfZwlcxFabixfEGn9QtW5WeDGsT2fKOIXHxrUqb4xgGYeQKONnMj6SUOTRPJeQFwkYBR1axFZOrwct34Pbg4sQhl69m3NT7hyxJqtIOrsWUdafubOoqByGOtNxl1ETwARA/at3DaYlJfX83rMJ7oJ8yUdAnJBDSF6YUWW+ndMOGbdgFrldl4F5shQawiDMEX5SEnX9reCKyp3KHvS+VnDiY2bNE1gdhldy8LFluqneBhh4J2yC5jzXG/c1amUf1/NuI4nD/otmuIcH8nS+tTK+qSALB0bwNNEqp++0TM65WgZIQeYtY445ObF3nazM/PI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1F17979D8D58C4499E710207C1E3367@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ab5984-524c-499e-ff81-08d711cc3b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 13:21:56.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jglauber@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2083
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_09:2019-07-26,2019-07-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 26, 2019 at 10:30:47AM +0800, Kevin Hao wrote:
> This patch series fixes two calltraces when the CONFIG_DMA_API_DEBUG is
> enabled. Build and boot test on a Marvell CN96XX-CRB board.
>=20
> Kevin Hao (2):
>   mmc: cavium: Set the correct dma max segment size for mmc_host
>   mmc: cavium: Add the missing dma unmap when the dma has finished.
>=20
>  drivers/mmc/host/cavium.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

(removing David & Steven who left Cavium)

Hi Kevin,

this is bad timing as I wanted to try the patches on my CN81xx board but
reviving it will take me some more time which I don't have as I leave
tomorrow.

Anyway, patches look correct to me.

thanks,
Jan
