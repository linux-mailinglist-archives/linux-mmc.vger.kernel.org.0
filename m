Return-Path: <linux-mmc+bounces-705-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FE83C381
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB361C2395E
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jan 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C094F8BC;
	Thu, 25 Jan 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="CLjfQ9s0"
X-Original-To: linux-mmc@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2118.outbound.protection.outlook.com [40.107.220.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A474F885
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188831; cv=fail; b=SEPpeLzNcYBkS1LM+cCxyqzgsUDi0C8+wMVbnJddQ/vby01SB/bCBNqOgtpfWGbEAGHVAB/ghqs5mPONXGkyU0D5x2yf41cmPGT2vz/XEQynyKLA4RXxd33N+RBi2eJxnP8qvuebExaVt3oEnN+3QNyzA6K7pABIObZQ/tH2h/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188831; c=relaxed/simple;
	bh=Mqf6lhG/UKNv9GYOYUTSqdPKQ/NVZ/kBorR7v4OJf+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU+qeonYAOKS1qp4qQyIogk2e1tUvvL+JZD15axBw8ku8qQurcSv9R3WLHeFFEUdgNsxFra92TnSHIxncG+63XVdUkCNHkPGCx1ZQgOiQk1NaJmDpX8GAXkk5gG785H4BO8GUglCslVNSCzbafW3bDGpio0qNd/jKGpLHP1EIyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com; spf=pass smtp.mailfrom=bayhubtech.com; dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b=CLjfQ9s0; arc=fail smtp.client-ip=40.107.220.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayhubtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8vbhxEju/vgBFPyDzTv0U6Hw/fFHqUW5/TGCsfHPx87rAM0tTLwm2m9euero5dj6sFDV7VFZuaNFrdntXLOAq2EK200Q1UDszQoAVUpiKR9wuNmuFu0Jwy4uNEthnZmDUVzxIvkcrvo+yHIQi6ZJVio2cWUN0OlssRl1XA8ujSwf+k1SkCsbYBDvbcTIXCE/YkYP5XvyJALevRcVjaHn/dVOaIuAbIht+mZOJMrfMkIxW6Avr9HhPygVlw/Uw/ZAlCWGc5Sqnhqdcwp1g7vFG/huAe6zy60xrbavT7kOdiFtyV/+3TMpAdSXR1xzZU5yQeHx+GXJbyOEcjebXP+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqf6lhG/UKNv9GYOYUTSqdPKQ/NVZ/kBorR7v4OJf+M=;
 b=KnbQwnpBxnzTZwVHJ236HXAlzdgT5N5vvVtfeVWiqOXTnek6mgu9djmt5hpMqTv14f1eXg0A16Ul77Qh9bLA3AAW0NSWvr1PWeR/q/b1RnZWSkaOOVXVuJaL79JDRZm0iXI+PBixZeQjBmZ8hOOhWCWSVREIitygxh7fnzrU7s9Fy74OI3Vb5xFrLL0z3BBHsBzw6yzateUO+f+lH+hvGnbfBQkEWZZl0RFcOwj4NEo4LVVncBmPyMvUJDEFQlvGVli4a3jtGugKd8dUdgk+fQ9cDH3ikmFpT0VEUG8DlcTNismhwRLpYHZ2XUptET9o/pUx4eJKgtgo7tRw3eBwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqf6lhG/UKNv9GYOYUTSqdPKQ/NVZ/kBorR7v4OJf+M=;
 b=CLjfQ9s0tYA4sHUsC4xRNiWRRawXEZgVrIk1JYJO1IZI9TMTQKJLmlY1xrcXiOB5E6DoYV4kORR5mPgoO2G2+zRzIJVV92W0yQklbWSWNcGGSx+Txn3zIpDaVQtRpgyb/FwcM/w2khT/NW7h6WgVY92e525rsFzoyCUaOjk5o5E=
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 BLAPR16MB3668.namprd16.prod.outlook.com (2603:10b6:208:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 13:20:25 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::917:8c93:febc:9d2f]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::917:8c93:febc:9d2f%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 13:20:25 +0000
From: "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Brent Roman <brent@mbari.org>, "Fred
 Ai(WH)" <fred.ai@bayhubtech.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
Subject: RE: Regression in sdhci-pci-o2micro.c
Thread-Topic: Regression in sdhci-pci-o2micro.c
Thread-Index: AQHaST9IjbpbGMqfpketvTJRtpDhGbDe6wLggABW2CCACboNAA==
Date: Thu, 25 Jan 2024 13:20:25 +0000
Message-ID:
 <DM4PR16MB50042D4CCB7AF6715F9AEBEFEA7A2@DM4PR16MB5004.namprd16.prod.outlook.com>
References: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
 <CAPDyKFqsRounzo1Ns0dDdCS9Qu0doq82ivYwEUNWgOiMtDS0Xg@mail.gmail.com>
 <DM4PR16MB50049CE307E3B479D80EFD95EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
 <DM4PR16MB50041AB09DA48C7FB8C41C57EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
In-Reply-To:
 <DM4PR16MB50041AB09DA48C7FB8C41C57EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR16MB5004:EE_|BLAPR16MB3668:EE_
x-ms-office365-filtering-correlation-id: 040c25f9-266e-4234-7906-08dc1da8645a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qlFnEZAuUqX3DFMNaxCeDnRQW7gN880IpTQXPVeYsvsmpiYV59yJGIpWssk1ZTEpz/tGSHgq5630cFV+NhWM17Yw0bpftB1Cc0EPIe+OiIMRNX5L44zZ4uXP8e/VyNJyg40Aog8sLQz/oPITW8SVAa4O7CMx62EsMG9VI1N0a3Iwo/m6Rt6HA6K2H1K3ClKRUXFf8B3R1cpmhJ1xI6XT0Vu8c64mWrWjF067WQSyiNigQiGq0wvCycrCgo4VjnIgDXReEDjkYkc/Q9EzC91uuOVlr4LOHgr0LCnQN95wXk7LaALWLvrhEUJseZl8lnZog8tTezb9dh3ktkDfby+aqJZe/6NiBGtYPtTuKUqzb4TJmzyGszncnCEGIViIH9kqehqueEqILvfIvrZ+QyFVWezu4eSv9CPtDdON7q6+ONYXPI5wYL8Btto46MtVYP7dyiH+sPiXpvT0BwoX5blvf16u8pdJPHYMTE0jF6hA2FJiPjGFTL6wIyJY6Oz7bVqECvoYV9j2AG0RwarqWBb0HmPRvIp87TweT7516/fw2yxiN/NGtqnclst9/PMnyee846BqbMRzNfRNqk/VkWkPPgdVN3rw1HOeJbG0jj0fLdGSwGbuVcCZVI3pjbdx1++4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(66899024)(8676002)(9686003)(71200400001)(6506007)(7696005)(53546011)(55016003)(8936002)(83380400001)(4326008)(5660300002)(66446008)(66476007)(64756008)(54906003)(66556008)(478600001)(66946007)(6636002)(110136005)(316002)(86362001)(122000001)(76116006)(38100700002)(52536014)(33656002)(38070700009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVZwNGtVQzEvU2Z5S2RVMlkvU1QzZTdKTWMzNFVlK3RSaUI4RkJtOTJBdCtU?=
 =?utf-8?B?cHdvdDAwS0dnd0V1L1pCNmN1U25QdnBLL1FVUzluOU03ZkhKR0ZXNE5PakNJ?=
 =?utf-8?B?eU9NZTJPZG1kV1RtRzJjV3puc3hpRnBma0l2bFlJV2pPQ0NuMHJjcjliSEJB?=
 =?utf-8?B?Ry9jVWxmeWhkdzQ1M3V2Z3FBQVo1aXlHQ0NuUHdJMnNCbUhOSVIzRkt0eXRz?=
 =?utf-8?B?WE10QnlHYmxTd1gwdFUxNldNbjJJMmp0Y1Z3RXNDR1g1b0ZXekUwKzFpdWxn?=
 =?utf-8?B?VmgvZ3JHZHNYMXlMdnpXMys0NHc2T3pnSks1UjRPQ1pReGI2Wk55K1owaGkw?=
 =?utf-8?B?ckl1S2FwZUswS0JwVHJFc1FIM2V6c3BhTGM3SUlTclpEWVJlR3F6b1ZQTy9C?=
 =?utf-8?B?L2xSdTVuQjRRVjRvemF5OEE4dzZ2b0YzWjdlUEpySUx1ZVY0bFUxVjAva2NC?=
 =?utf-8?B?ZGRGVVJyRDZnMzNMSThvUW8xS0crWnpoaFovQTg2cERuSm04ZjE3Q3h3ZU4w?=
 =?utf-8?B?ZkJVTDhsRTJESGdONk0wWkszK3FhSC96K1phOWM4SEF6ZjdzZzNIT2hHS1Br?=
 =?utf-8?B?cEtJY0o3SFBlUUlEeDNjS1h4ZC9yWm1sNWZoSElRdG02cUNqMXBkT2w1T1NX?=
 =?utf-8?B?U09hZXdRMkdVSzc1RmI1N3NiS05ka1ZLODU2Nk1US3U4cGxQRHN6VEFTa01V?=
 =?utf-8?B?SEZ1aGRad2c2MzRKWC83Z092KzRtMGdvbnpMT2gveXFIMWJGaHhFd3M4cGc1?=
 =?utf-8?B?YVI2Vzl3QXBkazg1WnZlcmpvUEFaWVV6LzB2MDlWM0Y4amlwOEhXNXMwY3Rh?=
 =?utf-8?B?MjJYQWU1UzYwWVc1NmFYa0dwaWxwOVRSMVBMWWx1MGJjdW56bnJCNnl0cVBN?=
 =?utf-8?B?bWlKS1ZndE5jSVVpYUFXT0R3VGZBc25NaEg3bWhOQ1A5UmlMb0JrbU9qc0R5?=
 =?utf-8?B?Mk1qQ3g2MW1XZm1ySDd5cENicDFSYjAxOG9GdDFFWEpHR0FJSDNKdkh3dG1Y?=
 =?utf-8?B?NnJQRFNCUUlDWXplaGdELzdVWnZoZXZhS3FjZlZPclBXRUYzK2VNY0x5MVM3?=
 =?utf-8?B?bTJVSU53bmhISWlQYzIvS2RIb0V2cnRVVE04dWZuUndpclZDY3IyWVdReUQx?=
 =?utf-8?B?V25PT1k4TEZTbW9KeEk1WElNNGNQT3Vtb0d3cVBoRXhEMGJUUHlIdHVSeVZl?=
 =?utf-8?B?Y3BjT3lKb2ZmR2tVaVpWWnhZMC9sSzcyc0haQjEwMjV4MVJwZjI1NU5oTUwz?=
 =?utf-8?B?c2Qwb3NKUklkVUtENzZtU2JTSzIxSEkvdENHRU14Y2pvVHhaWkU2Zkw0VVNr?=
 =?utf-8?B?djJvKzhhZlZ5b01xajQvVFNoSnZDcFZQZXd0R3l4eGs4V0U0ZXFTdFVBT28w?=
 =?utf-8?B?OFlMaUVkdjM5L2Fya1d6U1hmZUNwbkk2YU55Q1R1NzVqK3lUVGQwbzJ4TGZL?=
 =?utf-8?B?Nm1yYVN0K29pemJ1UkhaQTh1TE55MnhvbHR6bEJxaE9COSsrNXJMNjdHM3ZW?=
 =?utf-8?B?ZmlzMFVtNXpZbnNtY0trSC94cmdid1c0OTVvbGtzNkdDQ3lNWU1vRzl0cnJQ?=
 =?utf-8?B?bDUyL2svZzZORUpzRGtFNVo2bTRaUS9ua0MwS29nQm9tVjlnYmd0Q1dUNkhm?=
 =?utf-8?B?Zi9LM1F5aEM5cHBKM0hvYUkyWnVqb3FERVIrQjFTNDJ0NllnZ3RmYWVpUVIz?=
 =?utf-8?B?aktvY3RYSm1pRUFHSlJNZ2FJYkZwa1VIVHFidFl0bC9iblJuYk9DZkdTMDR2?=
 =?utf-8?B?Z3pRZy9WK1ZDRUMyRkdmK2U4SHEwenJEeVdhNTZxZ0NLSjFOWndWYXN4ZjdF?=
 =?utf-8?B?R0syNnB1RUJabzFTbFRybWpzZVY5aWJ6ZEgrZHg0SWEyd09QeklvdWhheXBt?=
 =?utf-8?B?Qm04NkNlS2dCaHhHSzJock9yVW9RR0FsSElCbjVRTHN1ZU9LbUZHU29pd0VW?=
 =?utf-8?B?UnhkZk01UWJqb0gybVZvQ1ZFWTFJdlpLUnNiQUFHajFGSUZoUDRNYzZyYkVG?=
 =?utf-8?B?RWlHUW9XaGtOYnRjbEZSZDBuc1VsdXNkYmRWcjk4ZzlKazE0eTRpMVBoY0VO?=
 =?utf-8?B?MUtrVk53UGRYaUYwa2xjcnVhR0Z1TjJNcjlXVUJpTXRTR094OWdHMXp0UUFa?=
 =?utf-8?Q?J+Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040c25f9-266e-4234-7906-08dc1da8645a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 13:20:25.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAxHjlkl0yRvBqsku1V9NAGv5Z5h++/KaDFAhM1tuYOE7WpWg9NmZ9Pn6tAR0uO2Uz07tfEru+wwXkxca7dYrIatKEFDrfmn7w3tMpdKsZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3668

SGksIFVsZi9BZHJpYW4sDQoNClNvcnJ5IGZvciByZXNwb25zZSBsYXRlLg0KDQpBZnRlciBjaGVj
a2VkIHNvbWUgZG9jdW1lbnRzIGludGVybmFsLCB3ZSB0aGluayBpdCdzIG5lY2Vzc2FyeSB0byBy
ZWdyZXNzaW9uICJtbWM6IHNkaGNpLXBjaS1vMm1pY3JvOiBBZGQgbWlzc2luZyBjaGVja3MgaW4g
c2RoY2lfcGNpX28yX3Byb2JlIiBpbiBzZGhjaS1wY2ktbzJtaWNyby5jIC4NCkJlbG93IGlzIHRo
ZSByZWFzb246DQpTb21lIGNoaXAgb2YgdGhpcyBoYXJkd2FyZShPMl9TRUFCSVJEMC9PMl9TRUFC
SVJEMSkgbWFpbiBwb3dlciBtYXkgYmUgbm90IHJlYWR5IHdoZW4gYWNjZXNzIGl0IGF0IGRyaXZl
ciBwcm9iZSBzdGFnZS4NClNvLCB0aGUgcGNpX3JlYWRfY29uZmlnX2R3b3JkKCkgY2FsbHMgZXJy
b3JzIHNob3VsZCBiZSBpZ25vcmVkIGF0IHByb2JlIHN0YWdlLg0KDQpCUiwNCkNoZXZyb24NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZXZyb24gTGkgKFdIKSANClNlbnQ6
IFRodXJzZGF5LCBKYW51YXJ5IDE4LCAyMDI0IDE2OjUzDQpUbzogJ1VsZiBIYW5zc29uJyA8dWxm
LmhhbnNzb25AbGluYXJvLm9yZz47ICdCcmVudCBSb21hbicgPGJyZW50QG1iYXJpLm9yZz47IEZy
ZWQgQWkoV0gpIDxmcmVkLmFpQGJheWh1YnRlY2guY29tPg0KQ2M6ICdsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnJyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47ICdBZHJpYW4gSHVudGVyJyA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQpTdWJqZWN0OiBSRTogUmVncmVzc2lvbiBpbiBzZGhj
aS1wY2ktbzJtaWNyby5jDQoNCkhpLCBVbGYvQWRyaWFuLA0KDQpQbGVhc2UgaWdub3JlIGZvcm1l
ciBlbWFpbC4NCkkgY29uZnVzZWQgaXQgd2l0aCBhbm90aGVyIGlzc3VlLg0KDQpJIGFncmVlIFJl
Z3Jlc3Npb24gIm1tYzogc2RoY2ktcGNpLW8ybWljcm86IEFkZCBtaXNzaW5nIGNoZWNrcyBpbiBz
ZGhjaV9wY2lfbzJfcHJvYmUiIGluIHNkaGNpLXBjaS1vMm1pY3JvLmMNCg0KRm9yIHRoZSBpc3N1
ZSBCcmVudCByZXBvcnRlZCwgd2Ugd2lsbCBjaGVjayBpdCBpbnRlcm5hbCBmaXJzdC4NCg0KQlIs
DQpDaGV2cm9uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGV2cm9uIExp
IChXSCkNClNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE4LCAyMDI0IDExOjUzDQpUbzogVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBCcmVudCBSb21hbiA8YnJlbnRAbWJhcmku
b3JnPjsgRnJlZCBBaShXSCkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQpDYzogbGludXgtbW1j
QHZnZXIua2VybmVsLm9yZzsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
DQpTdWJqZWN0OiBSRTogUmVncmVzc2lvbiBpbiBzZGhjaS1wY2ktbzJtaWNyby5jDQoNCkhpLCBV
bGYvQWRyaWFuLA0KDQpXZSB0cmllZCB0byBpbXBsZW1lbnQgdGhlICJyZW1vdmVfc2xvdCIgYXQg
InNkaGNpX3BjaV9maXhlcyIgYW5kIHJlY292ZXIgc29tZSBjaGFuZ2VkIFBDUiBjb25maWd1cmUg
dmFsdWUgZm9yIG5leHQgcmVib290IGF0IEJJT1Mgc3RhZ2UuDQpCdXQgSSdtIG5vdCBzdXJlIHRo
YXQgdGhlIGFkZGVkIHBhdGNoIGluICJyZW1vdmVfc2xvdCIgd2lsbCBiZSBjYWxsZWQgd2hlbiBP
UyByZWJvb3QuDQpJZiB0aGVyZSBhcmUgY2FsbGJhY2sgZm9yIG8ybWljcm8gaG9zdCBkcml2ZXIg
d2hlbiBPUyByZWJvb3QuDQoNCkF0dGFjaG1lbnQgaXMgYSBzYW1wbGUgY29kZSB3aGljaCBpbXBs
ZW1lbnRlZCB0aGUgInJlbW92ZV9zbG90IiBhdCAic2RoY2lfcGNpX2ZpeGVzIi4NCg0KQW55IHN1
Z2dlc3Rpb25zIHdpbGwgYmUgYXBwcmVjaWF0ZWQuDQoNCkJSLA0KQ2hldnJvbg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFy
by5vcmc+DQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTcsIDIwMjQgMjA6MTgNClRvOiBCcmVu
dCBSb21hbiA8YnJlbnRAbWJhcmkub3JnPjsgQ2hldnJvbiBMaSAoV0gpIDxjaGV2cm9uLmxpQGJh
eWh1YnRlY2guY29tPjsgRnJlZCBBaShXSCkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQpDYzog
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+DQpTdWJqZWN0OiBSZTogUmVncmVzc2lvbiBpbiBzZGhjaS1wY2ktbzJtaWNyby5j
DQoNCisgRnJlZCwgQ2hldnJvbiBMaSwgQWRyaWFuDQoNCk9uIFR1ZSwgMTYgSmFuIDIwMjQgYXQg
MjM6MTgsIEJyZW50IFJvbWFuIDxicmVudEBtYmFyaS5vcmc+IHdyb3RlOg0KPg0KPiBIaSwNCj4N
Cj4gSSBoYXZlIGFuIEludGVsIEhhZGVzIENhbnlvbiBOVUMgKE5VQzhpN0hWSykgd2hvc2UgTzIg
TWljcm8gYmFzZWQgDQo+IFNELUNhcmQgcmVhZGVyIGlzIG5vIGxvbmdlciBpZGVudGlmaWVkIHdo
ZW4gaXRzIExpbnV4IGtlcm5lbCBpcyANCj4gdXBkYXRlZCBwYXN0IDUuMTINCj4NCj4gSSAiZml4
ZWQiIHRoaXMgYnkgcmV2ZXJ0aW5nIGEgY2hhbmdlIGZyb20gNS85LzIxICAoZ2l0DQo+IGVmYzU4
YTk2YWRjZDI5Y2MzNzQ4N2E2MDU4MmQ5ZDA4YjM0ZjY2NDApDQo+IHRoYXQgaW5zZXJ0ZWQgcHJv
cGVyIGVycm9yIGNoZWNraW5nIGFmdGVyIGFsbCB0aGUgUENJIGNvbmZpZyBzcGFjZSANCj4gcmVh
ZHMgaW4gdGhlIGRldmljZSBwcm9iZS4NCj4gVGhpcyB3b3VsZCBiZSBjb2RlIHJlbW92ZWQgZW5j
bG9zZWQgaW4gI2lmIDAgYmVsb3c6DQo+DQo+ICAgICAgY2FzZSBQQ0lfREVWSUNFX0lEX08yX1NF
QUJJUkQwOg0KPiAgICAgIGNhc2UgUENJX0RFVklDRV9JRF9PMl9TRUFCSVJEMToNCj4gICAgICAg
ICAgLyogVW5Mb2NrIFdQICovDQo+ICAgICAgICAgIHJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRl
KGNoaXAtPnBkZXYsDQo+ICAgICAgICAgICAgICAgICAgTzJfU0RfTE9DS19XUCwgJnNjcmF0Y2gp
Ow0KPiAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4NCj4g
ICAgICAgICAgc2NyYXRjaCAmPSAweDdmOw0KPiAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2J5
dGUoY2hpcC0+cGRldiwgTzJfU0RfTE9DS19XUCwgc2NyYXRjaCk7DQo+DQo+ICAgICAgICAgIHJl
dCA9IHBjaV9yZWFkX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgTzJfU0RfUExMX1NFVFRJTkcsICZzY3JhdGNoXzMyKTsgI2lmIDANCj4gICAgICAg
ICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICNlbmRpZg0KPg0KPiAg
ICAgICAgICBpZiAoKHNjcmF0Y2hfMzIgJiAweGZmMDAwMDAwKSA9PSAweDAxMDAwMDAwKSB7DQo+
ICAgICAgICAgICAgICBzY3JhdGNoXzMyICY9IDB4MDAwMEZGRkY7DQo+ICAgICAgICAgICAgICBz
Y3JhdGNoXzMyIHw9IDB4MUYzNDAwMDA7DQo+DQo+ICAgICAgICAgICAgICBwY2lfd3JpdGVfY29u
ZmlnX2R3b3JkKGNoaXAtPnBkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9T
RF9QTExfU0VUVElORywgc2NyYXRjaF8zMik7DQo+ICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAg
ICAgICAgICBzY3JhdGNoXzMyICY9IDB4MDAwMEZGRkY7DQo+ICAgICAgICAgICAgICBzY3JhdGNo
XzMyIHw9IDB4MjUxMDAwMDA7DQo+DQo+ICAgICAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2R3
b3JkKGNoaXAtPnBkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9TRF9QTExf
U0VUVElORywgc2NyYXRjaF8zMik7DQo+DQo+ICAgICAgICAgICAgICByZXQgPSBwY2lfcmVhZF9j
b25maWdfZHdvcmQoY2hpcC0+cGRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBP
Ml9TRF9GVU5DX1JFRzQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNjcmF0Y2hf
MzIpOyAjaWYgMA0KPiAgICAgICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiAjZW5kaWYNCj4gICAgICAgICAgICAgIHNjcmF0Y2hfMzIgfD0gKDEgPDwg
MjIpOw0KPiAgICAgICAgICAgICAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTzJfU0RfRlVOQ19SRUc0LCBzY3JhdGNoXzMy
KTsNCj4gICAgICAgICAgfQ0KPg0KPiBCb3RoIHRob3NlIHBjaV9yZWFkX2NvbmZpZ19kd29yZCgp
IGNhbGxzIHJldHVybiAtRUlOVkFMIG9uIG15IG1hY2hpbmUuDQo+IFRoZSBkcml2ZXIgaGFkIGJl
ZW4gd29ya2luZyBlYXJsaWVyIHByZWNpc2VseSBiZWNhdXNlIGl0IHdhcyBpZ25vcmluZyANCj4g
dGhlc2UgZXJyb3IgcmV0dXJucyBmcm9tIHBjaV9yZWFkX2NvbmZpZ19kd29yZC4NCj4gSGF2ZSB5
b3Ugc2VlbiB0aGlzIGJlaGF2aW9yIGJlZm9yZSBvbiBhbnkgb3RoZXIgaGFyZHdhcmU/DQo+DQo+
IFRoZSBTRGNhcmQgcmVhZGVyIGlkZW50aWZpZXMgYXM6DQo+IDAzOjAwLjAgU0QgSG9zdCBjb250
cm9sbGVyOiBPMiBNaWNybywgSW5jLiBTRC9NTUMgQ2FyZCBSZWFkZXIgDQo+IENvbnRyb2xsZXIg
KHJldiAwMSkNCj4gMDM6MDAuMCAwODA1OiAxMjE3Ojg2MjEgKHJldiAwMSkNCj4NCj4gSSd2ZSBi
ZWVuIHVuYWJsZSB0byBmaW5kIC9hbnkvIGluZm9ybWF0aW9uIG9uIHRoaXMgY2hpcC4NCj4gRG8g
eW91IGhhdmUgYW55IHlvdSBjb3VsZCBzaGFyZT8gIEEgZGF0YXNoZWV0IHdvdWxkIGJlIGlkZWFs
IDotKQ0KPg0KPiBBbHNvOg0KPiBJJ3ZlIGFsd2F5cyBoYWQgdG8gb3BlcmF0ZSB0aGlzIGRyaXZl
ciB3aXRoIGRlYnVnX3F1aXJrczI9NCB0byBkaXNhYmxlIA0KPiB1bHRyYSBoaWdoLXNwZWVkIHN1
cHBvcnQuDQo+IElzIHRoaXMgYSBrbm93biBpc3N1ZT8NCj4gT3IsIGNvdWxkIGl0IGJlIGEgc3lt
cHRvbSBvZiB0aGUgZmFpbGluZyBwY2lfcmVhZF9jb25maWdzIGN1cmluZyBwcm9iZT8NCj4NCj4g
VGhhbmtzIGZvciB5b3VyIGF0dGVudGlvbiwNCg0KTG9va3MgbGlrZSB0aGUgb2ZmZW5kaW5nIGNv
bW1pdCBlZmM1OGE5NmFkY2QgKCJtbWM6IHNkaGNpLXBjaS1vMm1pY3JvOg0KQWRkIG1pc3Npbmcg
Y2hlY2tzIGluIHNkaGNpX3BjaV9vMl9wcm9iZSIpLCBtYXkgbm90IGhhdmUgYmVlbiB0aG9yb3Vn
aGx5IHRlc3RlZC4gUGVyaGFwcyBhIHJldmVydCBpcyBuZWVkZWQuDQoNCkxldCdzIHNlZSBpZiBG
cmVkL0NoZXZyb24gTGkgaGFzIHNvbWUgdGhvdWdodHMgYXJvdW5kIHRoaXMuDQoNCktpbmQgcmVn
YXJkcw0KVWZmZQ0K

