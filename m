Return-Path: <linux-mmc+bounces-6265-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C4A966F8
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Apr 2025 13:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60CA189D3FA
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Apr 2025 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBD27703B;
	Tue, 22 Apr 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Il9ysE4a"
X-Original-To: linux-mmc@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFE221FBA;
	Tue, 22 Apr 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320160; cv=fail; b=piWsSSD/Xvo8Ba6z65n3YXjeMnIANq6Gxk5FHcLomjbW8wu/KuGoZqbzdruopENG0+XzEVIRyc1kP299OMhKx6yP4A2MOmd8P/uq8kkcGaZ8YLY9IpmyGpLaMaPG4pNOhioHwi0Yfg0mshNGxzwIP013lGMVgpMQ86nGi1StqC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320160; c=relaxed/simple;
	bh=taGvSyY2ytFjnuyyFba9LeRo9onVvAeys906omHMotE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KK5gLxg3rjAOHLCs3ISIAeOJ3ojH41EBNPAZ0ev8gUEIshF1qrmey1iCny9N21d/2sZKUl76C3FtS7X6VNxsEyS2NXdgxDiDdXaveKK1/TnxKdT1rEEQ0oNO8qx/QL4WqHEbE5WXtkDhDkme4r2qzIY2DN2IanHQSnFOsace9HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Il9ysE4a; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y56HJKNCqL00IyOJ8D0fI5N4nF2suag66maty5ix7N1ADywfPU5D9PHgpyOWTvfeMoHcqIwI8PDUXZ68lR5oGyZaGXUBx6+SNuKAS7iFTCWOufuf1WScvJEbiB0tgszxdG1G2QRQRPqkJXLYx9Z/L0IpRtszsNa4wOEcFy7uvMomTIIdP+e6NI4rvt9k1jh4RLlHgkWmDBjPFAgi6T31EH8fkP582xTfRPFvTwrAUbuUfTuIEjzQUskEFm0s9o8JQ/0yUS4IRWSl4R2Am35LVy2mgapgmOvxIerqYLyI31XfRWnk4yTd/bhqE/Piw/aqlpCFT9UurfpHa11rEr86Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taGvSyY2ytFjnuyyFba9LeRo9onVvAeys906omHMotE=;
 b=uBRRwg0RJFKK1F3WZpH5pET0Ha2c7cUxKYjw2+JzHcLkJiFCasDzXvemNQoYcWXTFn+KrxxcQtdDSwK7FeE7oaZv9gb2gl+NgC1sjErTXRo4+h5YJJLnAeKFQlptdLTYP4YTqtJK1YoNgRAlBNfXXxXoRTomMX+cQSN/w1uMHIt+FaLFei82+TjWjreTdKMWFWHQX5b3Y6+BD/zsCZ2fkoyLIkQKaURrk9ybVuoO2Pz0inCKq2HGLJk+8u80Xer4kCaC7RDmY0ZYe7JS1W1H+JR1hOw8PsskKQCP1UblXXccYY86VQAKtgy764clXkjwBReENSa5trvvsrpcZgkhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taGvSyY2ytFjnuyyFba9LeRo9onVvAeys906omHMotE=;
 b=Il9ysE4aK3BAT2dTUp1DLxcV9r3XSRo+C8aKG73bXOgy/vP4zGVO8M8rZ+P2XBrBMWDKOXDp68JZJmHwnDLoOA2B1ySxRtq6V2gWXdjKBr5OTlB1/Xz5URXH7thBPK72PiT2IB/PX+hkE9cQ3ilpASL0GQNGpuju6avbDhe1sOIgs6Dxo74aqUjwwrMn+cxE2Lv1zLlTxpDpocjCARywuYZYYf2tM7ucn3mIjCj2VY071l8jKS3hqaRjNJj2XeXllqrohAU0DRTy0OGFL2bm0zgQRvokcUM9Z03Lmdowz1v1JVDOVCgSgYzBSBjOkdw6T+q62GWgZZVJjPgXYY5wEg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by VI0PR04MB10230.eurprd04.prod.outlook.com (2603:10a6:800:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 11:09:13 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 11:09:13 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Bough Chen <haibo.chen@nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 6/6] mmc: sdhci-esdhc-imx: switch standard
 tuning to manual tuning
Thread-Topic: [EXT] Re: [PATCH 6/6] mmc: sdhci-esdhc-imx: switch standard
 tuning to manual tuning
Thread-Index: AQHbqSS3yq6UpZog9E6iw4UlcmZnsbOvlzWAgAADwQA=
Date: Tue, 22 Apr 2025 11:09:13 +0000
Message-ID:
 <DU2PR04MB8567CD0D26D91EE1EEC52599EDBB2@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
 <20250409075550.3413032-7-ziniu.wang_1@nxp.com>
 <465c3e5a-8b6a-47e0-9777-a6ed15669964@intel.com>
In-Reply-To: <465c3e5a-8b6a-47e0-9777-a6ed15669964@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|VI0PR04MB10230:EE_
x-ms-office365-filtering-correlation-id: 6db81c80-26f0-410f-2839-08dd818e1d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUIxOThONFpxT0dEYStrTGFBcEo4OUlUakVNMHdveVZCaHd1UktidjNhNlR5?=
 =?utf-8?B?MUpIZEtQeHQyd3pUOGo5Q1RZeWFlWjdiLzRQaXhFK0d6d09SL2RlakF4NUZq?=
 =?utf-8?B?S2NQZERnK25yTDRpaE5nMEFLZG5ZSEVvZ2IvM2RXM2QyUG9ORTZ4bmxCMXV4?=
 =?utf-8?B?SGVWVnBSZDJFM3QyNlBtVFY5a0hQUzFUNHRHUHpiZkhJVUVGSlJIaHluVjk4?=
 =?utf-8?B?b25hY1VHdGUzd01qbHI3Qmd5VUhzcFF1b2Q3RkRqL1Y4QXh1bWh5MkxpUW5a?=
 =?utf-8?B?UkcvQVQxQzdtcjNNNkVyTjBUOEN2WUdoS0FQdmgxOHpHTUthbnFWSFQzUFgw?=
 =?utf-8?B?SEsxamVsU1FtWWRWZHdybWNDUnRWaVI5anNzNnFVaGFDL3IweFJxUllJN1Uz?=
 =?utf-8?B?aWhQUFdoM08zUkZSaU15KzMwVW4xN2lHWU5uQzdLaTVvOFVzZ3pMVTk5LzYz?=
 =?utf-8?B?K0laT08raXhBWVdTc0ZpcGxRTkpabVZHMTc4K3dTV0p0T3FheDE4cjc2WTBk?=
 =?utf-8?B?TEYrbWdySGxqZDNkSFdwR2I2ZzBHWDYzRndKNlNPRFFCQ3U3QUZkd2M2NGc1?=
 =?utf-8?B?Rk0zU042V0JTMEpPNjhwUmQzVko5ZjVZeEVJbUdJQ3E2SjJYN3JKdUtzdlhn?=
 =?utf-8?B?QTlrZVhrWk8vcG5talIyN0crcUdpb0NRTUV2VnA1cHNtT2czQ0pSU1RpS1ZN?=
 =?utf-8?B?NmkxVjRLWVlReW43YVozV3h1eEZuRDRTUkNabVVWOUhmVWNWbHVXN0o2Umlp?=
 =?utf-8?B?cDh2bUFyTzFHUSsvd09mVHR1WTN1RmUrbmlsUGtRemFxWmpmTXplMS9PZ0N6?=
 =?utf-8?B?SUt4a2taYzlXUDI4TWdpWFdpYit1b2g2NWE3WXRTU05QVi94SDMwRlVTWHU3?=
 =?utf-8?B?eGZvL09qTlhwS2VVUlFMc2Q3UkdxRmxnejFVVW5HSm9sUjF6ZHBob3dkZDI4?=
 =?utf-8?B?ZWlNZ2dSZTVpdE13cE5ZdHZmUlprd3RPTUp4Mk52RDluemZaVEFBT2tHVzNH?=
 =?utf-8?B?ZmQyNDE4anV2Qi9ZbWhndWdpK0RnZmdwdHFMMUNueFdrOUxJZ1JGSHJkK29D?=
 =?utf-8?B?eWpLbXBJK0duUHUzQTJqK05Eb1VIQ3I0T1Z2UVFzeHJuRC9TWTU0WGJub3Ez?=
 =?utf-8?B?TjllS1VKMjJ2YkJ6VGtNMlZhazFReUREUjJVNkJYOW1FaHhNL2Jaa1NmaTdX?=
 =?utf-8?B?cnE1cEFqUTJJWE9kWnVPWHdQMGVta04yRlJrZTQvbXhnMjRJU2FUQVhIdVRm?=
 =?utf-8?B?NEpRNUFHT21iVDR6UVNTZ1cvTGpvS2x1YTRDay9uVXpESUVpa1R5eDB2RVdu?=
 =?utf-8?B?alo2bUJpQm0yRjNGK3BWYjNBZUZ4ZGJ6TVBLQmFrUzZaU0MwcGNNdnhGNTVI?=
 =?utf-8?B?aUZKNG1LOXZjNm85ei9qWTBwR2xiRWVDcWEySzN2V2szdWlVVXBOQzRZRlFZ?=
 =?utf-8?B?MStOeTROS0FWaTJ0T1RoQW90dnRVMUVTdy9FN0Y0REhuTFFhdXQrdldLemZk?=
 =?utf-8?B?SG8xWWNVTjZhQ3ZzZWdFeEtWNGlqa0JjTlI5Q0RoemZ3dmM4U3NvNkxtbFZs?=
 =?utf-8?B?Y2RYcmppZ2xZTGZKWEpKNXY0SGZLZWVKZUIzNE11QTR2QzBhR3hsWUJrMmZ3?=
 =?utf-8?B?TldlVDdNRytvT1N5M2FDdWw5RDYrUVcxLy9RemRYODE5c05oczhkRkp3bENv?=
 =?utf-8?B?UHcxVEpGZHl0czBmTzl1eWFPZWlIdmVJaVBhS295QmJmTHVrUG5YNUxVcStL?=
 =?utf-8?B?anJxMTh0WGJoUXBFM1padFlkUlRjVnMrOHBLRXZLU0JrOTRsS0M2OE1MNDNC?=
 =?utf-8?B?a0xENDYxeVEwKzlvZ2lSV0hWTUx1WEZJcEZPd3RtSHNtT0YzV0xpU3Z4UUQw?=
 =?utf-8?B?TGlOdStwZHF6YktvM0ZPMVRCRURnRkNibFVjRnM2SCswcmtuRVRNTTJVYmxy?=
 =?utf-8?B?ajlPSEpXWjQvbkY5RXNCOVRDOHhFVXNSUDA4czd6ZjBidUtoUFZwR0t3azF5?=
 =?utf-8?B?bFMzdnkxcGxRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWFjLzVzN0Zaa05MK0UxY1JXRWxzcTlmQVUrckhPaE91bnppbWhpMTZ3MjNO?=
 =?utf-8?B?b3RXbHlURmV3b0UxeVcxNlkvRURjWE4vandkYVd3L1poOWY5ekhETlBZRmdZ?=
 =?utf-8?B?OFh4RXFVTlBwNDdZUklMbmNZVkk5OW5WdTc1eUtDTWNkdWNjcmtlV1BzZWR4?=
 =?utf-8?B?YWtabldwaWRSdjBnU2VoMWZ6SW4rR0J3K2lmamcvV2RENDFqdXBUeFVFZUVV?=
 =?utf-8?B?K2tJdHFhVGZacDd1M3pYZXdYUXVCU1NzUGF2aWdsalpsSDZEYzQ0a2p3SFpM?=
 =?utf-8?B?eWdhbVBvSWROUmJrTU1obGp3MTRFRTYwdjVCbk5oZUF3WWdlMHUvM0h5QTZK?=
 =?utf-8?B?WWJxelhpdXJwSW45d01Bb1F3WmFTckRzNURLRW9hMXFRWDJ3eEplZ0JUN0k3?=
 =?utf-8?B?b3VBQXpqMklkNDRvazBvYTJTenNFOE1XSUFhNFJYQXcxZFVubmtNcXVhL0Nk?=
 =?utf-8?B?aExtbWw4ZG50bStsNkprMmJiZnNqeFpPZFN0Z0haNXlZMU42VFFOUU43UWJU?=
 =?utf-8?B?TXRlMnlPQkpyZ2tIamM5aWpPSm5NRDlkVVFRWUtWWkhwcHhqN3hBUVQyZVFp?=
 =?utf-8?B?VFdPbDFlTWZ0NC9LVGwwWHhlMndFVUlUbEs2RW45ZG45SU1XZU1nV3BFMDha?=
 =?utf-8?B?TXpoZWRWdGpnYUttaURDWGVqMmhuek1GNUtnVFN1NXIzZmVRTWFxcVk3RGRQ?=
 =?utf-8?B?aW1hMGtUSFFKQjNKSk9iajlIY3RPVkgyVnpwRnd2RmEzSWVjSUk3NGhGY09o?=
 =?utf-8?B?bDhiblgxdy9ZTGcrbmpRWlZkWjNXblM4alB4a1ZDZUllVVEwUEpMVUYyWG1T?=
 =?utf-8?B?aWN5NnpBaUlpbUxXV2VFU0ZObmNjTFpaV0N6aWRPRjhmL2tVMFREMUZ6c3lW?=
 =?utf-8?B?TUgvMVZldGVBSWZ3akdwdjI4MTRBeXVlNVBvQXg2V25FZUxYbFFMYjFSSGt1?=
 =?utf-8?B?V1Via2pPTytSNWQ4cHJYYTZHT29qRlQ2MnBRdWZWODVzYVFkVlhFVGFxc2tO?=
 =?utf-8?B?MkdLOXBUTVRVNmhINkdMbU1xUFZhZlo1ZTV3dUh5SnZhc1RsMkxMZ1FKcjho?=
 =?utf-8?B?K05yaWpIdWpPUmVySzYvTy9XRXNHbHJhVmVOMVRTUmEyR0E5YWl6ZVpGSGE2?=
 =?utf-8?B?bU9jOGN4LzJ0R0VTT0l1WHRPK2NsOEJLOStWUittdlFHRm9TanBBSWEwWHhp?=
 =?utf-8?B?SzdtWUduaVJjdUh3b1YzSytQYXJyK1FubDlYK0FCSnFiempjelJaL0hEUkMy?=
 =?utf-8?B?dDVIZ01XMWl0cmMvSEhDb0NJc1FFY3NOanUzL0VXTEJIMTlQRFZlVGtZdTFH?=
 =?utf-8?B?VDdDLzJNU0FjbTkvZzJWMitEbWpMamY0N1B6MTV1cGx5dnlIdkU1cXhZMVNG?=
 =?utf-8?B?bHJnczJtR204L3JCbjZzcmpQeFRZWlNKUDRlUGoxYWwvcTExTFkyMkpTTlhG?=
 =?utf-8?B?UE9RbVQyV3VOUXU5WVVxck5qa2RXOC93ZktaRVJYazFnOHROVmZlK09rbkxp?=
 =?utf-8?B?MkttengxWXhDOVFaaVpQRGV3WHFrczl4aGxPOWE1UlE0MGRHMGI1UjdnVkZj?=
 =?utf-8?B?S1pwcWZlSlBhdG5kdXhTSzM3Ty91ei9BcXlNUGk3SkxyUllmazBmSmJFTkg5?=
 =?utf-8?B?U2xBbjV6QTk0bFMrV1p3SnJWaHJFQ1RoUGpQaXliY1BPbGpZdmJOMzBuL3Fo?=
 =?utf-8?B?K2ZoRG1NR013alp4N3lSdjVuOWZzWlJWNGN3WDBmdmt1ay9jUW92UzZyTWJJ?=
 =?utf-8?B?bWZndm1mRzhneUdqblRBZ2Y0MEY2ZHdlSmFId3dxTGhHWEc2c0czbDBSNmZC?=
 =?utf-8?B?VG15eGxzTEpBMGwwK2diaktJbXkrOTUrL1BDVi90YWlmSHZ6MkRGRDd1cE9Z?=
 =?utf-8?B?RWhSZGxackVOUytiUUh4YXlZYkhIenFQSUwwKy95YU1VNUZ2RXFUYnROdi9B?=
 =?utf-8?B?dHRaSVJxNDNmZ1NINVBRNEltQzVDVS9nWjNvVldXWlhmM25idkJJS0ZqOGpH?=
 =?utf-8?B?bHZ3Nk0wamt3OHVkL0Y4dzl4Mk52ekNMaFl1V1N5UXJJeFNsQWtjdU1qY3ow?=
 =?utf-8?B?ME9qODhtQWVENkYxSlFXT2lrMDhyYURMK1JWMUJDUGJ6MkVyTWZrRFo5cVpO?=
 =?utf-8?Q?C9Wwc21WMH4lY2bdhbxbiQ8mI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db81c80-26f0-410f-2839-08dd818e1d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 11:09:13.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82I7bK7C98jAWti5b1d+4IpL6pXcOlpp63IQ/8k1hk4+8AUqUlFsWlnkg0S2nkHZ4f6lJWc9LvYVz66OaQkn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10230

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIyLCAyMDI1
IDY6NTMgUE0NCj4gVG86IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+OyB1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnOyBCb3VnaA0KPiBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENj
OiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsg
bGludXgtDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLVMzMiA8UzMyQG54cC5jb20+OyBsaW51
eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggNi82XSBtbWM6IHNkaGNpLWVz
ZGhjLWlteDogc3dpdGNoIHN0YW5kYXJkIHR1bmluZw0KPiB0byBtYW51YWwgdHVuaW5nDQo+IA0K
PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdo
ZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3Vi
dCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1
dHRvbg0KPiANCj4gDQo+IE9uIDkvMDQvMjUgMTA6NTUsIHppbml1LndhbmdfMUBueHAuY29tIHdy
b3RlOg0KPiA+IEZyb206IEx1a2UgV2FuZyA8emluaXUud2FuZ18xQG54cC5jb20+DQo+ID4NCj4g
PiBDdXJyZW50IHN0YW5kYXJkIHR1bmluZyBoYXMgc29tZSBsaW1pdGF0aW9uczoNCj4gPg0KPiA+
IDEuIFN0YW5kYXJkIHR1bmluZyBvbmx5IHRyeSA0MCB0aW1lcyB0byBmaW5kIGZpcnN0IHBhc3Mg
d2luZG93LCBidXQgdGhpcw0KPiA+IHBhc3Mgd2luZG93IG1heWJlIG5vdCB0aGUgYmVzdCBwYXNz
IHdpbmRvdy4NCj4gPg0KPiA+IDIuIFNvbWV0aW1lcyB0aGVyZSBhcmUgdHdvIHR1bmluZyBwYXNz
IHdpbmRvd3MgYW5kIHRoZSBnYXAgYmV0d2Vlbg0KPiA+IHRob3NlIHR3byB3aW5kb3dzIG1heSBv
bmx5IGhhdmUgb25lIGNlbGwuIElmIHR1bmluZyBzdGVwID4gMSwgdGhlIGdhcCBtYXkNCj4gPiBq
dXN0IGJlIHNraXBwZWQgYW5kIGhvc3QgYXNzdW1lcyB0aG9zZSB0d28gd2luZG93cyBhcyBhIGNv
bnRpbnVvdXMNCj4gPiB3aW5kb3dzLiBUaGlzIHdpbGwgY2F1c2UgYSBiYWQgZGVsYXkgY2VsbCBu
ZWFyIHRoZSBnYXAgdG8gYmUgc2VsZWN0ZWQuDQo+ID4NCj4gPiAzLiBTdGFuZGFyZCB0dW5pbmcg
bG9naWMgbmVlZCB0byBkZXRlY3QgYXQgbGVhc3Qgb25lIHN1Y2Nlc3MgYW5kIGZhaWx1cmUNCj4g
PiB0byBwYXNzIHRoZSB0dW5pbmcuIElmIGFsbCBjZWxscyBpbiB0aGUgdHVuaW5nIHdpbmRvdyBw
YXNzLCB0aGUgaGFyZHdhcmUNCj4gPiB3aWxsIG5vdCBzZXQgdGhlIFNESENJX0NUUkxfVFVORURf
Q0xLIGJpdCwgY2F1c2luZyB0dW5pbmcgZmFpbGVkLg0KPiA+DQo+ID4gNC4gU3RhbmRhcmQgdHVu
aW5nIGxvZ2ljIG9ubHkgY2hlY2sgdGhlIENSQywgZG8gbm90IHJlYWxseSBjb21wYXJlIHRoZSBk
YXRhDQo+ID4gcGF0dGVybi4gSWYgZGF0YSBwaW5zIGFyZSBjb25uZWN0ZWQgaW5jb3JyZWN0bHks
IHN0YW5kYXJkIHdpbGwgbm90IGRldGVjdA0KPiA+IHRoaXMga2luZCBvZiBpc3N1ZS4NCj4gPg0K
PiA+IFN3aXRjaCB0byBtYW51YWwgdHVuaW5nIHRvIGF2b2lkIHRob3NlIGxpbWl0YXRpb25zDQo+
IA0KPiBJcyBpdCBuZWNlc3NhcnkgdG8gaGF2ZSBzdGFuZGFyZCB0dW5pbmcgYXQgYWxsIHRoZW4/
DQoNCk9uZSBhZHZhbnRhZ2Ugb2Ygc3RhbmRhcmQgdHVuaW5nIGlzIHRoYXQgaXQgY2FuIGJlIGF0
dGVtcHRlZCB1cCB0byA0MCB0aW1lcy4gVXN1YWxseSwgb25lIHN0YW5kYXJkIHR1bmluZyB0YWtl
cyBhYm91dCAyMCB0byAzMCBtaWxsaXNlY29uZHMgdG8gY29tcGxldGUuIEhvd2V2ZXIsIGluIG9y
ZGVyIHRvIG9idGFpbiBhIGJldHRlciB3aW5kb3cgdGhyb3VnaCBtYW51YWwgdHVuaW5nLCAxMjcg
dHVuaW5nIGF0dGVtcHRzIHdpbGwgYmUgbWFkZSwgd2hpY2ggdGFrZXMgYXBwcm94aW1hdGVseSBv
dmVyIDEwMCBtaWxsaXNlY29uZHMuIA0KDQpUaGUgZm91ciBsaW1pdGF0aW9ucyBtZW50aW9uZWQg
YXJlIGFsbCBwcmFjdGljYWwgaXNzdWVzIGVuY291bnRlcmVkIG9uIGRpZmZlcmVudCBpLk1YIHBs
YXRmb3Jtcw0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVrZSBXYW5nIDx6aW5pdS53
YW5nXzFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy1pbXguYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS0NCj4g
ZXNkaGMtaW14LmMNCj4gPiBpbmRleCBmZDBhZDBhZDE1MTkuLjliNjZlMDdlZDhlNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IEBAIC0yNzUsMzUgKzI3NSwz
NSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRhDQo+IHVzZGhjX2lteDZxX2Rh
dGEgPSB7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBlc2RoY19zb2Nf
ZGF0YSB1c2RoY19pbXg2c2xfZGF0YSA9IHsNCj4gPiAtICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFH
X1VTREhDIHwgRVNESENfRkxBR19TVERfVFVOSU5HDQo+ID4gKyAgICAgLmZsYWdzID0gRVNESENf
RkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICB8IEVTREhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19FUlIwMDQ1MzYNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgfCBFU0RIQ19GTEFHX0hTMjAwDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHwgRVNESENfRkxBR19CUk9LRU5fQVVUT19DTUQyMywNCj4gPiAgfTsNCj4gPg0K
PiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lteDZzbGxfZGF0
YSA9IHsNCj4gPiAtICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNESENfRkxBR19T
VERfVFVOSU5HDQo+ID4gKyAgICAgLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZM
QUdfTUFOX1RVTklORw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB8IEVTREhDX0ZMQUdfSEFW
RV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB8IEVT
REhDX0ZMQUdfSFM0MDANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfCBFU0RIQ19GTEFHX1NU
QVRFX0xPU1RfSU5fTFBNT0RFLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14NnN4X2RhdGEgPSB7DQo+ID4gLSAgICAgLmZsYWdz
ID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfU1REX1RVTklORw0KPiA+ICsgICAgIC5m
bGFncyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RIQ19GTEFHX01BTl9UVU5JTkcNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgfCBFU0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMy
MDANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfCBFU0RIQ19GTEFHX1NUQVRFX0xPU1RfSU5f
TFBNT0RFDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHwgRVNESENfRkxBR19CUk9LRU5fQVVU
T19DTUQyMywNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3Nv
Y19kYXRhIHVzZGhjX2lteDZ1bGxfZGF0YSA9IHsNCj4gPiAtICAgICAuZmxhZ3MgPSBFU0RIQ19G
TEFHX1VTREhDIHwgRVNESENfRkxBR19TVERfVFVOSU5HDQo+ID4gKyAgICAgLmZsYWdzID0gRVNE
SENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICB8IEVTREhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICB8IEVTREhDX0ZMQUdfRVJSMDEwNDUwDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIHwgRVNESENfRkxBR19TVEFURV9MT1NUX0lOX0xQTU9ERSwNCj4gPiAgfTsN
Cj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lteDdk
X2RhdGEgPSB7DQo+ID4gLSAgICAgLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZM
QUdfU1REX1RVTklORw0KPiA+ICsgICAgIC5mbGFncyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RI
Q19GTEFHX01BTl9UVU5JTkcNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfCBFU0RIQ19GTEFH
X0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
fCBFU0RIQ19GTEFHX0hTNDAwDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHwgRVNESENfRkxB
R19TVEFURV9MT1NUX0lOX0xQTU9ERQ0KPiA+IEBAIC0zMTksNyArMzE5LDcgQEAgc3RhdGljIHN0
cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19zMzJnMl9kYXRhID0gew0KPiA+ICB9Ow0KPiA+DQo+
ID4gIHN0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14N3VscF9kYXRhID0gew0K
PiA+IC0gICAgIC5mbGFncyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RIQ19GTEFHX1NURF9UVU5J
TkcNCj4gPiArICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNESENfRkxBR19NQU5f
VFVOSU5HDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHwgRVNESENfRkxBR19IQVZFX0NBUDEg
fCBFU0RIQ19GTEFHX0hTMjAwDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHwgRVNESENfRkxB
R19QTVFPUyB8IEVTREhDX0ZMQUdfSFM0MDANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfCBF
U0RIQ19GTEFHX1NUQVRFX0xPU1RfSU5fTFBNT0RFLA0KPiA+IEBAIC0zMzIsNyArMzMyLDcgQEAg
c3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YQ0KPiB1c2RoY19pbXhydDEwNTBfZGF0YSA9IHsN
Cj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lt
eDhxeHBfZGF0YSA9IHsNCj4gPiAtICAgICAuZmxhZ3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNE
SENfRkxBR19TVERfVFVOSU5HDQo+ID4gKyAgICAgLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8
IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB8IEVTREhD
X0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICB8IEVTREhDX0ZMQUdfSFM0MDAgfCBFU0RIQ19GTEFHX0hTNDAwX0VTDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHwgRVNESENfRkxBR19TVEFURV9MT1NUX0lOX0xQTU9ERQ0KPiA+IEBA
IC0zNDEsNyArMzQxLDcgQEAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19pbXg4
cXhwX2RhdGENCj4gPSB7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIHN0cnVjdCBlc2RoY19z
b2NfZGF0YSB1c2RoY19pbXg4bW1fZGF0YSA9IHsNCj4gPiAtICAgICAuZmxhZ3MgPSBFU0RIQ19G
TEFHX1VTREhDIHwgRVNESENfRkxBR19TVERfVFVOSU5HDQo+ID4gKyAgICAgLmZsYWdzID0gRVNE
SENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfTUFOX1RVTklORw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICB8IEVTREhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICB8IEVTREhDX0ZMQUdfSFM0MDAgfCBFU0RIQ19GTEFHX0hTNDAw
X0VTDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHwgRVNESENfRkxBR19TVEFURV9MT1NUX0lO
X0xQTU9ERSwNCg0K

