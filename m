Return-Path: <linux-mmc+bounces-4388-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9011D9A31FA
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2024 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B9C1F22612
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577D56742;
	Fri, 18 Oct 2024 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZjLi8Dl"
X-Original-To: linux-mmc@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1E55E53;
	Fri, 18 Oct 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214564; cv=fail; b=u6V7AR3vDz9ptoB37re2zH0I4THUYl2tG4cxfCj2vrSpE00a5FOQ857UGifwn3KiZ9lOb5AGxbwNyI36hTd0NwxaK8RL32wrukDffOUGXEktfObUJ2OsvSd6Vr1TB8Hih0xZCH5r718dVj2boDkTpPLuTtXkyM9aEfwy0YR48Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214564; c=relaxed/simple;
	bh=xPz0GnLbtV+DzKuQHUCv0DNc70wm7zxa7zdX0ssc2dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epaSIbvi9yLFgEaRSpmGLHgbDoAqmGBCznl69zuGwtleFw/YrOb8qAY7dTrtTq9mx6KAr63Db/uhltfrHwSbOfTlroKOr0dTeWXWZetX7UYM8P4hKzIe/qGsfrlmXKfeIKF9x4k5TihGSg8b+xAhei8nKwB4nhYWig2+7qs848M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZjLi8Dl; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuKXkmtYIEjFOb+nMLAWKR9BVX91BeY21xZTWJLylBlJXOdwPq6tqP+wqmx09scWgrgs0HUtsk2tK6hBOkQEsDuQQALB0UwB/4qVO6A7ssI9IIzdo9PCSAAeDuE+iqDgq/cd/yNIw8EiJefHMDEfHqPDN08hfqwRO9dt6AG8L6Jc+fzcC3nnCr/7yAj5AzrmaHqT+P+jn15ifcFfAuNAwHbYvEzkBBWh0T+4LxnFKJsgKTt4bjIMEG/w2RAu0UFSlQwGc1mBn3HdCoz6SAJIH3dxoiQcRDxXvKSdbFmtsZerPvWJlzZMBZkWJbirvl4kgk4AAU+oDYN2u9Id90oDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPz0GnLbtV+DzKuQHUCv0DNc70wm7zxa7zdX0ssc2dU=;
 b=SZqKllmaUFv9KmxQwPDmKXbGnxtgfCqxoaphWyTNEyHFzmUMFY/NXUTt7LZyMRCl+FCLStXEvn+uQl2Mc+iR8bFvDEx3MIzzkCFdBkVezxbCs36Rtbw4kW3ELo3qEy/aOFFgRps/RQJdC+M3Kiailah+WrpO0HLpWIGyBvNIxALacZmSJzLaiHiC6huzFRlvJwXNX43jfx7q/hip74JSFNlpv10lYa+rOg3CRQcyVNjNj/+1iwIrPFXP0bDxfk+ZC2WBEQVBfsZOrHpBtgn4aSr5vFse6e8kHihVeivTDt0bcpMyA3JgwyXNO0iPjA4SWasBLIkYuiShwea1MihDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPz0GnLbtV+DzKuQHUCv0DNc70wm7zxa7zdX0ssc2dU=;
 b=AZjLi8Dl/gG7+xfu1WYtap1PZ+32k8eGitqXBorQS3ZGNhdJ3V85yj3Ac3hsEk+FWFE7zBlrAUg7NObBzQxcpn3paWuXO4p2kW0pI8ICq06wzQ9NBEN9mxFG539MHXZTYFY/JhS7TQdK0WpSprrN1qF6A9URL0LTbFjNK3+GGQ0zpI/AlZ0dOvz65p0WvqKFZs/IIAqgUgj+C4wWwR21aGWmwkUHmprIsFcMkf+GUl7E5NRF70vKzuP2IJo/Kof7gffY5DMxmhmMtproJ2gdTTDs45aBfUy1fDH2rxr3OfnOxaIZgr8Jbkakt9Vsd1yLb4jLeeIu6Rfft1uSN0ITkQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10380.eurprd04.prod.outlook.com (2603:10a6:150:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 01:22:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 01:22:32 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM
 logic
Thread-Topic: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM
 logic
Thread-Index: AQHbHf5hd7QD6nrSMUOqpbNFCm+ShrKK7wQAgADLNKA=
Date: Fri, 18 Oct 2024 01:22:32 +0000
Message-ID:
 <DU0PR04MB949604108991809742E83E5D90402@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241014060130.1162629-1-haibo.chen@nxp.com>
 <20241014060130.1162629-3-haibo.chen@nxp.com>
 <CAPDyKFr37wLYxdFJ-Lgbq7PbWyiQz+CuwMxwgeeP3QpMvdyjqg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFr37wLYxdFJ-Lgbq7PbWyiQz+CuwMxwgeeP3QpMvdyjqg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GV1PR04MB10380:EE_
x-ms-office365-filtering-correlation-id: 42a70c52-6204-4323-64ed-08dcef13571a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUpFMmZqR2UrekN3Rk5KbGs0VmRTZWNJaVM0WWQ2S1I5OHdNRGtjbHV6eFg3?=
 =?utf-8?B?Q2FjaFB4dFVqdWorRDdyOVdXUHlRVU56Y2xDREF0ZmtyOGtjU29lWTZtRlNp?=
 =?utf-8?B?MlR5dGlnVjRvRmpXNUNqU0FnNnJJTmNQZzlkTVdNTnplaXdoeDRGcGwyWXZi?=
 =?utf-8?B?WVliYWhoTi8zV2NQUVNvSURDbkRMM0JWTVVsMUtKKzkxWkhOUzNkNlFWQzZF?=
 =?utf-8?B?QmpXWkF0UTQyczYvV0hGOHdsbEVXck5wU3FDZTdwQjhsTlMreHAxSmQ3cFph?=
 =?utf-8?B?L0RqcU02K2VoTENpaVA2YW14SWtXYVZGNXROaXBWTUc2aXZqVi9tbzdFWkNH?=
 =?utf-8?B?Rkc2SHFiSUdkVU5jMUJpUEVqRlNOV0MwYnArZ210bXp6bUh6cjdpR2l0YU9u?=
 =?utf-8?B?M1BHajNGUmlRR3ZONUt3WGkydmd0NVJaRFdGWDNycTc0YU83ekVFT2NwWGk5?=
 =?utf-8?B?UmxkRE8rUktjYWRkV1FXazNpZmdpUmQ2TU45Y0pnRlJVdUdLanB0eGoyODd5?=
 =?utf-8?B?alEwZXNweVNvN2hZYm1hWndWUDV3SVhENDlBb3d5MWxMZVplYzlqUi9jbmNT?=
 =?utf-8?B?OGVCSlhsWTA5dFZzcVFlbFdYWVptSjJZRGtvZGxqczlORVpEOEgxcmppTzhY?=
 =?utf-8?B?OEdpVG91dTJqWGVzdWt4UTVwZWlWa01BVEVrQ04rSU9YQkFsOUNPKzlidnAv?=
 =?utf-8?B?MTNmVWVVU3lNdWZ2THljaUg0NUxmYTNNREtuZlNYZjlvYVRhVDJsa0w1Nndt?=
 =?utf-8?B?eXZMVjFOVmJnQnJXSGMzZmlTSUFwQXBLUUtZUFRpbVJIR0EvbHZpVVNpREdo?=
 =?utf-8?B?MUhEMGp4d2NIRHZKSjBsYVg0RjZLeU8vejVMd25JK2VmVmdqck1UZDcrS2VI?=
 =?utf-8?B?a0R2emFTdmZIc2hFZ2g3VXp0anpyWGFWL2dHdVBMZU5YRFBINU5JckNxMFBs?=
 =?utf-8?B?ajNGT3Y0SlZJSkhrNFkyRUxkNnF4QmFTeTFSQkZDWCtDMFQvOGtUUGJwMHIz?=
 =?utf-8?B?QnVUMS9udGVHYndmbHdYRlVBQlBmbkgwcFpNYjNtaERwUjdvRnhHWFNiOXM5?=
 =?utf-8?B?UHdocnJPTnlIZmJsQnltazhNREVMTUtsTnRRVTNLRmFSRHYySi8vb1hHaDdU?=
 =?utf-8?B?TkM5d2JoUGJQbktBTjdsOURzUDR6MzEyWW9WV0VUb1pMUFJ2V3JOdTE2Q05G?=
 =?utf-8?B?N3ZvdUxVaXFBS1dubzJqbjhSSEIwajB5d0RJTTBVZXViVko5azlyUSsxMUUw?=
 =?utf-8?B?NWxRTVR6Z04yUDNydzR0WVNrYW4zb2gvNHEyMStNUXRadndzSG9COUFXajFU?=
 =?utf-8?B?b0d1cHlEblE2RFp3NDBLS01TRmRTSmtUVHRTQjgza0lSTVFkTHlrT1dtNlI3?=
 =?utf-8?B?UnE1QW0wcVNmdGFjb0M0ZmYwNWxkSU9pVGFEMU9BRSsrNTQ0OENoNXA5T2h6?=
 =?utf-8?B?dHUyUEQyc25TcTFReTZtdGRQdDlNYkpsT0VOMDZwb1BCWXJlSG5qaGt0UlYw?=
 =?utf-8?B?NzZTT21EMUNCNEdXQk4zUFJYdnhPbGZHQ3VzeE9wdVJYeDVvVEdZMEFPaEc5?=
 =?utf-8?B?QVJwK0J6TXYzRnE2Y0RQVUM5SkRHWWF2c1RTM0FQUnoxWkxLYjdCOXVvMHZC?=
 =?utf-8?B?SVhuZisvVXliS0F5Rkx5RGJDTVJlaUdVRG9BbDBCeXZVTFBrY3JtVkhkNjBT?=
 =?utf-8?B?V0NwM25MKzhFY1habDJJS0swUHRrY1FOckdBSUczRXFFR2hsWEFjbnRPd0tv?=
 =?utf-8?B?em56NGhoVGxYNFNXQWhBeS9JQmpGUmN4R1lzd2FTUkQ3NHNqdk1SdVQyQU5L?=
 =?utf-8?Q?oCWlgZh2JRIKkEZFlagioW7iC2tsBpTURvllA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tkl6MmRSc1h6OXMrbW0rcy8rbklaYlhBV0tCQ2dTZ0QvaVcyK2FpMTZsdVA1?=
 =?utf-8?B?a0V4T29TTFhZYnkzYm8rNjZ1dTlFeVhzUDhzdmU0Y21nYWxTczB6Q21iVFVP?=
 =?utf-8?B?eFRlbVBTaHlPYWlyS3d3bXIwQmxhaVVPOXF0eVF1alZxSS9CTmlQc0ZLTWxT?=
 =?utf-8?B?UzBRd2o3eUtZVWtxZHA5bnB4czdsMjlvZmdDN1dLRFFIdXNTVmhkVVNQdW0x?=
 =?utf-8?B?WStCN3FUSXNPOHpvN21qM1NjcXNHUDdGTlQ3QkIrL1JBekJSRkhrSExvL3Rx?=
 =?utf-8?B?dmFLWCs3dk9oYWhkRHpJMEkxN0padzhxU0EzcmhFT2NUSDdCRnNXdkxOdU9y?=
 =?utf-8?B?NmpyeU9QQ21qbkdRd2RYLzlkUGlRVFcwMG9pZ1NQU2pUMVhDbGdiczRpVGJv?=
 =?utf-8?B?UHhXYU5GNHdDWVNWR0VCVlVDYUlFVDN3VE94eWd5TEd3SlFTUzB4alJ6dGlD?=
 =?utf-8?B?MVhXelM0YmFoVjhZWTM0MTV4QVF6c3ppN0g5UWZQVHNrb1diZFAycTZ0d2NI?=
 =?utf-8?B?Q2ZmNStzdFhFVTF0RStxK2pyMTM5cnF2eDAyc2VMTDJWK3VXM2hKZTdTTXhG?=
 =?utf-8?B?MFprMHJPdWtBUmQ2QmxxVFlCd05GaHhnWlVTSVVPYVlaOTFlWEYvRVpmajZU?=
 =?utf-8?B?a2Vlc3V6RmtUOFhyQ3YzRld3dFFheXFKVWdVT1BPbmttNHEzWXRDTzVZc1RM?=
 =?utf-8?B?a0pPWVlJQXBDTHBzK1FtanQyamt4alFUS0VTMkdQeHBJZHo3L0Yvd2NJRGd3?=
 =?utf-8?B?U3ZhRi9WcjJ6ZGo5N09OTlB6K0k4Ny9PSWV4ME1wb0l6UkpsWTVqOW9vR0ln?=
 =?utf-8?B?UjZJb2xyeDFLNEI2Vi9YVmFaUlpoSXd5eHFFS28vMEhRMHJxVUE4TVBLYWJx?=
 =?utf-8?B?NnJOZmhJQiswdzhSNmRYWEFYaDlDR0h5bUpWajFrVmJMY2xjazRHWnJydWJR?=
 =?utf-8?B?NFdldldGRHRBemgvUFNyQzBzbWV4eU9nQndZdjEyRUFualJGaElPTTBONjBU?=
 =?utf-8?B?dXpKUytNdVQ2WC82dGpnTEJJOUdyVVV0RUljb3d3Wms4ampzK2prUWdRRmF6?=
 =?utf-8?B?cTZuUTFwM0R2THo5dW1kaDh1WGpQbC9pOVVpcWZkcmNxd3l3M3E2bWlIZXZl?=
 =?utf-8?B?eUtKME56dnVYc3E3L3RDSWJqTmxtaFBJYW9TZVpDNFF1Mi9qYmxaTGs3bUEz?=
 =?utf-8?B?elVYc2pINENRTUFSSkdqMXBqL01DK0hFekNISkJTU2tIdjk5cUNXZndnVTF3?=
 =?utf-8?B?Sm9IWVNqbGVxblBFckRlRU01MDZMK0lNNTBoNFlvMXJBMlE5OGR4M3l0K2k4?=
 =?utf-8?B?YjdrTmlMakZ5dEpCSnFFLzJXcmtWcytiRHRpVkVCNWRpekh2QUJaV25qdFVw?=
 =?utf-8?B?Q3pneHVoNzFkSjZGZ3UyMWNFeHlUemxIVitQbEJXaGhPdHpRUXdiUUNKVld4?=
 =?utf-8?B?bUFzdXdxZmwyZlV6dExQc3YybUNXT3lHdzc3a1o4OUYwU2NLWEFQY2o1OTQ5?=
 =?utf-8?B?YlZITW1SNmgvY3FyTFl2WkUyMGZ6d2d3MTBpZFI4TGFSVG5QSEFyWHVtL0pU?=
 =?utf-8?B?bXZMaDRqczlXTklsdWYyN0NRYU14RS80cWUyRDlGS3oyakltVEczdEcxZGdz?=
 =?utf-8?B?NHpKMG8wNEZ4ZmJ3Ui9jbGtUOEV0SXRjTU14SFN0cFRucGZsTnFzUWQwYWh0?=
 =?utf-8?B?S1JuUEZMVmN2UHhWRmNWUzV2QjZuelJSYi9jWFh1azMxMFlSN3RzREdFbnlX?=
 =?utf-8?B?emZJTXVOZzF6YnZodGxCRDBYMW41UUgzakdsZVdsUUx3TkVjdE45SkdZU2hx?=
 =?utf-8?B?SWpWc0VWeko3UkFnVTZFSHM5SC9wNno1Ynk0NDR5bmU0RGJ0NGxkb3NWNWJI?=
 =?utf-8?B?VXI4dUdVWTFiYlZISmZ2RnRERjdwOGtEQ05RQXZFemFTSDNHZ29PcmtXUzZz?=
 =?utf-8?B?MWFmL2xQYXR4RUc0QzJrR3pKNVBBMUJUcFlsVm9sc0lxL3RZekErMytWV1Fk?=
 =?utf-8?B?QXoyUzRHOEtMS2VIMzhsL1BXNGQ3dmhrZGtiVXJDdmoyVnJjZCs0aG8waVVq?=
 =?utf-8?B?VXpDNElvM1FUZ2pCYVp4dVgxamZ4RkF1QWhLSjZ4bXRCbUhFUXlHTEtuWURp?=
 =?utf-8?Q?4kYc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a70c52-6204-4323-64ed-08dcef13571a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:22:32.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soTR3mkx4fYjO2DX1GbWXhHoZLLmdoZWvmJKlVFe3vIRZt/xdGdlX9oTEV8LJ6qRzR+RRcx2kND4Jm7O8gkhug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10380

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNOW5tDEw5pyIMTfml6UgMjE6MDcNCj4gVG86
IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0K
PiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtUzMyIDxTMzJAbnhwLmNvbT47
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gbW1jOiBob3N0OiBzZGhj
aS1lc2RoYy1pbXg6IHJlZmFjdG9yIHRoZSBzeXN0ZW0gUE0NCj4gbG9naWMNCj4gDQo+IE9uIE1v
biwgMTQgT2N0IDIwMjQgYXQgMDg6MDAsIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gQ3Vy
cmVudCBzdXNwZW5kL3Jlc3VtZSBsb2dpYyBoYXMgb25lIGlzc3VlLiBpbiBzdXNwZW5kLCB3aWxs
IGNvbmZpZw0KPiA+IHJlZ2lzdGVyIHdoZW4gY2FsbCBzZGhjaV9zdXNwZW5kX2hvc3QoKSwgYnV0
IGF0IHRoaXMgdGltZSwgY2FuJ3QNCj4gPiBndWFyYW50ZWUgaG9zdCBpbiBydW50aW1lIHJlc3Vt
ZSBzdGF0ZS4gaWYgbm90LCB0aGUgcGVyIGNsb2NrIGlzIGdhdGUNCj4gPiBvZmYsIGFjY2VzcyBy
ZWdpc3RlciB3aWxsIGh1bmcuDQo+ID4NCj4gPiBOb3cgdXNlIHBtX3J1bnRpbWVfZm9yY2Vfc3Vz
cGVuZC9yZXN1bWUoKSBpbiBOT0lSUV9TWVNURU1fU0xFRVBfUE0sDQo+ID4gYWRkIGluIE5PSVJR
IHN0YWdlIGNhbiBjb3ZlciBTRElPIHdha2V1cCBmZWF0dXJlLCBiZWNhdXNlIGluIGludGVycnVw
dA0KPiA+IGhhbmRsZXIsIHRoZXJlIGlzIHJlZ2lzdGVyIGFjY2VzcywgbmVlZCB0aGUgcGVyIGNs
b2NrIG9uLg0KPiA+DQo+ID4gSW4gc2RoY2lfZXNkaGNfc3VzcGVuZC9zZGhjaV9lc2RoY19yZXN1
bWUsIHJlbW92ZSBzZGhjaV9zdXNwZW5kX2hvc3QoKQ0KPiA+IGFuZCBzZGhjaV9yZXN1bWVfaG9z
dCgpLCBhbGwgYXJlIGhhbmRsZWQgaW4gcnVudGltZSBQTSBjYWxsYmFja3MNCj4gPiBleGNlcHQg
dGhlIHdha2V1cCBpcnEgc2V0dGluZy4NCj4gPg0KPiA+IFJlbW92ZSBwaW5jdHJsX3BtX3NlbGVj
dF9kZWZhdWx0X3N0YXRlKCkgaW4gc2RoY2lfZXNkaGNfcmVzdW1lLA0KPiA+IGJlY2F1c2UNCj4g
PiBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSgpIGFscmVhZHkgY29uZmlnIHRoZSBwaW5jdHJsIHN0
YXRlIGFjY29yZGluZw0KPiA+IHRvIGlvcyB0aW1pbmcsIGFuZCBoZXJlIGNvbmZpZyB0aGUgZGVm
YXVsdCBwaW5jdHJsIHN0YXRlIGFnYWluIGlzDQo+ID4gd3JvbmcgZm9yDQo+ID4gU0RJTzMuMCBk
ZXZpY2UgaWYgaXQga2VlcCBwb3dlciBpbiBzdXNwZW5kLg0KPiANCj4gSSBoYWQgYSBsb29rIGF0
IHRoZSBjb2RlIC0gYW5kIHllcywgdGhlcmUgYXJlIGNlcnRhaW5seSBzZXZlcmFsIHByb2JsZW1z
IHdpdGggUE0NCj4gc3VwcG9ydCBpbiB0aGlzIGRyaXZlci4NCj4gDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAzOQ0KPiA+ICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1lc2RoYy1pbXguYw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiA+IGluZGV4IGM3NTgyYWQ0NTEyMy4uMThmZWJmZWI2MGNmIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gQEAgLTE4NzEsMTEgKzE4NzEsMTMgQEAgc3Rh
dGljIGludCBzZGhjaV9lc2RoY19zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gPiAg
ICAgICAgIHN0cnVjdCBwbHRmbV9pbXhfZGF0YSAqaW14X2RhdGEgPSBzZGhjaV9wbHRmbV9wcml2
KHBsdGZtX2hvc3QpOw0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPg0KPiA+IC0gICAgICAgaWYg
KGhvc3QtPm1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpIHsNCj4gPiAtICAgICAgICAgICAgICAg
cmV0ID0gY3FoY2lfc3VzcGVuZChob3N0LT5tbWMpOw0KPiA+IC0gICAgICAgICAgICAgICBpZiAo
cmV0KQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gLSAgICAg
ICB9DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogU3dpdGNoIHRvIHJ1bnRpbWUgcmVz
dW1lIGZvciB0d28gcmVhc29uczoNCj4gPiArICAgICAgICAqIDEsIHRoZXJlIGlzIHJlZ2lzdGVy
IGFjY2Vzcywgc28gbmVlZCB0byBtYWtlIHN1cmUgZ2F0ZSBvbiBpcGcgY2xvY2suDQo+IA0KPiBZ
b3UgYXJlIHJpZ2h0IHRoYXQgd2UgbmVlZCB0byBjYWxsIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBm
b3IgdGhpcyByZWFzb24uDQo+IA0KPiBIb3dldmVyLCB0aGUgcmVhbCBxdWVzdGlvbiBpcyByYXRo
ZXI7IFVuZGVyIHdoYXQgY2lyY3Vtc3RhbmNlcyBkbyB3ZSByZWFsbHkNCj4gbmVlZCB0byBtYWtl
IGEgcmVnaXN0ZXIgYWNjZXNzIGJleW9uZCB0aGlzIHBvaW50Pw0KPiANCj4gSWYgdGhlIGRldmlj
ZSBpcyBhbHJlYWR5IHJ1bnRpbWUgc3VzcGVuZGVkLCBJIGFtIHN1cmUgd2UgY291bGQganVzdCBs
ZWF2ZSBpdCBpbg0KPiB0aGF0IHN0YXRlIHdpdGhvdXQgaGF2aW5nIHRvIHRvdWNoIGFueSBvZiBp
dHMgcmVnaXN0ZXJzLg0KPiANCj4gQXMgSSB1bmRlcnN0YW5kIGl0LCB0aGVyZSBhcmUgbWFpbmx5
IHR3byByZWFzb25zIHdoeSB0aGUgZGV2aWNlIG1heSBiZSBydW50aW1lDQo+IHJlc3VtZWQgYXQg
dGhpcyBwb2ludDoNCj4gKikgVGhlIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnQgaGFzIGJlZW4gYnVt
cGVkIGluIHNkaGNpX2VuYWJsZV9zZGlvX2lycSgpLA0KPiBzaW5jZSB0aGUgU0RJTyBpcnFzIGFy
ZSBlbmFibGVkIGFuZCBpdCdzIGxpa2VseSB0aGF0IHdlIHdpbGwgY29uZmlndXJlIHRoZW0gZm9y
DQo+IHN5c3RlbSB3YWtldXAgdG9vLg0KPiAqKSBUaGUgZGV2aWNlIGhhcyBiZWVuIHVzZWQsIGJ1
dCBub3RoaW5nIHJlYWxseSBwcmV2ZW50cyBpdCBmcm9tIGJlaW5nIHB1dCBpbnRvIGENCj4gbG93
IHBvd2VyIHN0YXRlIHZpYSB0aGUgLT5ydW50aW1lX3N1c3BlbmQoKSBjYWxsYmFjay4NCj4gDQo+
ID4gKyAgICAgICAgKiAyLCBtYWtlIHN1cmUgdGhlIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZCgp
IGluIE5PSVJRIHN0YWdlDQo+IHJlYWxseQ0KPiA+ICsgICAgICAgICogICAgaW52b2tlIGl0cyAt
PnJ1bnRpbWVfc3VzcGVuZCBjYWxsYmFjay4NCj4gPiArICAgICAgICAqLw0KPiANCj4gUmF0aGVy
IHRoYW4gdXNpbmcgdGhlICpub2lycS1jYWxsYmFja3MsIHdlIHNob3VsZCBiZSBhYmxlIHRvIGNh
bGwNCj4gcG1fcnVudGltZV9mb3JjZV9zdXNwZW5kKCkgZnJvbSBzZGhjaV9lc2RoY19zdXNwZW5k
KCkuIEFuZCB2aWNlIHZlcnNhIGZvcg0KPiBzZGhjaV9lc2RoY19yZXN1bWUoKS4NCj4gDQo+IEFs
dGhvdWdoLCBhY2NvcmRpbmcgdG8gbXkgZWFybGllciBjb21tZW50IGFib3ZlLCB3ZSBhbHNvIG5l
ZWQgdG8gdGFrZSBpbnRvDQo+IGFjY291bnQgdGhlIFNESU8gaXJxLiBJZiBpdCdzIGJlaW5nIGVu
YWJsZWQgZm9yIHN5c3RlbSB3YWtldXAsIHdlIG11c3Qgbm90IHB1dA0KPiB0aGUgY29udHJvbGxl
ciBpbnRvIGxvdyBwb3dlciBtb2RlIGJ5IGNhbGxpbmcgcG1fcnVudGltZV9mb3JjZV9zdXNwZW5k
KCksDQo+IG90aGVyd2lzZSB3ZSB3aWxsIG5vdCBiZSBhYmxlIHRvIGRlbGl2ZXIgdGhlIHdha2V1
cCwgcmlnaHQ/DQoNClRoYW5rcyBmb3IgeW91ciBjYXJlZnVsIHJldmlldyEgDQpZZXMsIEkgYWdy
ZWUuDQoNCj4gDQo+ID4gKyAgICAgICBwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+ID4NCj4g
PiAgICAgICAgIGlmICgoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYNCj4gRVNESENfRkxBR19T
VEFURV9MT1NUX0lOX0xQTU9ERSkgJiYNCj4gPiAgICAgICAgICAgICAgICAgKGhvc3QtPnR1bmlu
Z19tb2RlICE9IFNESENJX1RVTklOR19NT0RFXzEpKSB7IEBADQo+ID4gLTE4ODMsMTIgKzE4ODUs
MTEgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gPiAgICAgICAgICAgICAgICAgbW1jX3JldHVuZV9uZWVkZWQoaG9zdC0+bW1jKTsNCj4gPiAg
ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKGhvc3QtPnR1bmluZ19tb2RlICE9IFNESENJ
X1RVTklOR19NT0RFXzMpDQo+ID4gLSAgICAgICAgICAgICAgIG1tY19yZXR1bmVfbmVlZGVkKGhv
c3QtPm1tYyk7DQo+ID4gLQ0KPiA+IC0gICAgICAgcmV0ID0gc2RoY2lfc3VzcGVuZF9ob3N0KGhv
c3QpOw0KPiA+IC0gICAgICAgaWYgKHJldCkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gPiArICAgICAgIGlmIChkZXZpY2VfbWF5X3dha2V1cChkZXYpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldCA9IHNkaGNpX2VuYWJsZV9pcnFfd2FrZXVwcyhob3N0KTsNCj4gPiArICAg
ICAgICAgICAgICAgaWYgKCFyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dh
cm4oZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBpcnEgd2FrZXVwXG4iKTsNCj4gPiArICAgICAgIH0N
Cj4gPg0KPiA+ICAgICAgICAgcmV0ID0gcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2
KTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gQEAgLTE5MDQsMjIgKzE5MDUsMTggQEAgc3Rh
dGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAg
ICAgICAgc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
PiAgICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAtICAgICAgIHJldCA9IHBpbmN0cmxfcG1fc2Vs
ZWN0X2RlZmF1bHRfc3RhdGUoZGV2KTsNCj4gPiArICAgICAgIHJldCA9IG1tY19ncGlvX3NldF9j
ZF93YWtlKGhvc3QtPm1tYywgZmFsc2UpOw0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+ICAgICAgICAgLyogcmUtaW5pdGlhbGl6
ZSBodyBzdGF0ZSBpbiBjYXNlIGl0J3MgbG9zdCBpbiBsb3cgcG93ZXIgbW9kZSAqLw0KPiA+ICAg
ICAgICAgc2RoY2lfZXNkaGNfaW14X2h3aW5pdChob3N0KTsNCj4gDQo+IFRoaXMgbG9va3MgbGlr
ZSBhbm90aGVyIHNwZWNpYWwgdXNlLWNhc2UuIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIG9u
IHNvbWUNCj4gcGxhdGZvcm1zIHNvbWUgYWRkaXRpb25hbCByZS1pbml0aWFsaXphdGlvbiBvZiB0
aGUgY29udHJvbGxlciBtYXkgYmUgbmVlZGVkIGF0DQo+IHN5c3RlbSByZXN1bWUuDQo+IA0KPiBJ
ZiB5b3Ugd2FudCB0byBtb3ZlIHRvd2FyZHMgdXNpbmcgcG1fcnVudGltZV9mb3JjZV9zdXNwZW5k
fHJlc3VtZSgpLCBJDQo+IHN1Z2dlc3QgbW92aW5nIHRoZSBhYm92ZSBjYWxsIGludG8gdGhlIC0+
cnVudGltZV9yZXN1bWUoKSBjYWxsYmFjay4gVG8gYWxsb3cNCj4gdGhlIC0+cnVudGltZV9yZXN1
bWUoKSBjYWxsYmFjayB0byBrbm93IHdoZW4gdGhpcyByZS1pbml0aWFsaXphdGlvbiBpcyBuZWVk
ZWQsDQo+IHdlIGNhbiB1c2UgYSBmbGFnIHRoYXQgd2Ugc2V0IGhlcmUgYW5kIGNsZWFyIGluIHRo
ZSAtPnJ1bnRpbWVfcmVzdW1lKCkNCj4gY2FsbGJhY2suDQoNClllcywgSSBjYW4gZG8gbGlrZSB0
aGF0LiBTZWVtcyBJIGNhbiByZW1vdmUgdGhlIE5PSVJRIGluIHYyLg0KDQpUaGFua3MgZm9yIHlv
dXIgc3VnZ2VzdGlvbg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQoNCg0KPiANCj4gPg0KPiA+IC0g
ICAgICAgcmV0ID0gc2RoY2lfcmVzdW1lX2hvc3QoaG9zdCk7DQo+ID4gLSAgICAgICBpZiAocmV0
KQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IC0NCj4gPiAtICAgICAgIGlm
IChob3N0LT5tbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1FFKQ0KPiA+IC0gICAgICAgICAgICAgICBy
ZXQgPSBjcWhjaV9yZXN1bWUoaG9zdC0+bW1jKTsNCj4gPiArICAgICAgIGlmIChob3N0LT5pcnFf
d2FrZV9lbmFibGVkKQ0KPiA+ICsgICAgICAgICAgICAgICBzZGhjaV9kaXNhYmxlX2lycV93YWtl
dXBzKGhvc3QpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoIXJldCkNCj4gPiAtICAgICAgICAgICAg
ICAgcmV0ID0gbW1jX2dwaW9fc2V0X2NkX3dha2UoaG9zdC0+bW1jLCBmYWxzZSk7DQo+ID4gKyAg
ICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldik7DQo+ID4gKyAgICAgICBwbV9ydW50
aW1lX3B1dF9hdXRvc3VzcGVuZChkZXYpOw0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+ICB9DQo+ID4gQEAgLTIwMTEsNiArMjAwOCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2
X3BtX29wcyBzZGhjaV9lc2RoY19wbW9wcw0KPiA9IHsNCj4gPiAgICAgICAgIFNFVF9TWVNURU1f
U0xFRVBfUE1fT1BTKHNkaGNpX2VzZGhjX3N1c3BlbmQsDQo+IHNkaGNpX2VzZGhjX3Jlc3VtZSkN
Cj4gPiAgICAgICAgIFNFVF9SVU5USU1FX1BNX09QUyhzZGhjaV9lc2RoY19ydW50aW1lX3N1c3Bl
bmQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZGhjaV9lc2RoY19ydW50
aW1lX3Jlc3VtZSwgTlVMTCkNCj4gPiArICAgICAgIFNFVF9OT0lSUV9TWVNURU1fU0xFRVBfUE1f
T1BTKHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcG1fcnVudGltZV9mb3JjZV9yZXN1bWUpDQo+ID4gIH07DQo+ID4N
Cj4gPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc2RoY2lfZXNkaGNfaW14X2RyaXZl
ciA9IHsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZm
ZQ0K

