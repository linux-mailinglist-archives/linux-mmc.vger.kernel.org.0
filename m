Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAC23E1D
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfETRN3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 13:13:29 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:34117
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388626AbfETRN3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 May 2019 13:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ2CueFAro5eKYJF6jLIWcBjpbCFddKkVyb+ezEb+Aw=;
 b=4NGGWzrsaEkVWtQ/4lN8GiuBMD8GkbFvZ2lbyS7dRET77GzSOcOEqzaDdhbRa8240h1w+C3wMmDwaeNXfrJgDQWdV80nj3tQcjv03fFteD2yPMVyZdqpzaUwJiWo8MH89sEX9+AiBvbusiNe+dY9OsR/iwucL5xsA7jfad22Avc=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5982.namprd08.prod.outlook.com (20.179.99.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 17:13:26 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b45d:52ac:9ad5:9549]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b45d:52ac:9ad5:9549%4]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:13:26 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Chris Ball <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [EXT] RE: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Topic: [EXT] RE: [PATCH V3] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Index: AdTvoXWOn75nh0U7Ta2A6hwTLWaWDgABgSOgB+BkLKA=
Date:   Mon, 20 May 2019 17:13:26 +0000
Message-ID: <MN2PR08MB5951978BF8359761366DE33BB8060@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951783BA8508D7C50907044B82E0@MN2PR08MB5951.namprd08.prod.outlook.com>
 <SN6PR04MB4925B8AB586DDA99BA17DB50FC2E0@SN6PR04MB4925.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4925B8AB586DDA99BA17DB50FC2E0@SN6PR04MB4925.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [104.129.202.91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b67526b6-fddf-429a-8f42-08d6dd46791c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR08MB5982;
x-ms-traffictypediagnostic: MN2PR08MB5982:|MN2PR08MB5982:
x-microsoft-antispam-prvs: <MN2PR08MB59825F8FE0537152651B73F9B8060@MN2PR08MB5982.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(66446008)(76116006)(66556008)(66946007)(64756008)(316002)(26005)(99286004)(5660300002)(52536014)(186003)(33656002)(66476007)(73956011)(76176011)(71200400001)(71190400001)(6246003)(25786009)(74316002)(6506007)(102836004)(110136005)(55236004)(478600001)(14454004)(86362001)(7696005)(53936002)(3846002)(256004)(229853002)(6116002)(2501003)(2906002)(7736002)(305945005)(11346002)(9686003)(6436002)(4744005)(476003)(486006)(446003)(8936002)(81166006)(81156014)(8676002)(55016002)(66066001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5982;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EXl4J/XG1iHdnq41mbafc6iO0biwg61q8yGQlC4ZGfM1/ljAbc6yGgb4r1yvcLrp0GrrqENDK+vrXTTF/E4d4aJ3h6m4DLcJDwPoJKc2cnI8O0Pg37EL4HGGDYuR6JMGhPLaryKTM3DpGooie7wjb3NUDGBjPsVgH55Wy1NshSBfTIlBUwWJ4E8ooqzNE2Nuli49BOi6VvjY+ntUrtKwE8PYY4JZIIkW6o1yUndH2ZQ0O2hcubolRREu6eh1ZWeIVsagb7rVbmE1L8tgmn75gBPCLJnLvvykPFGja8Me0csBAkLAFzZ02sMfNl49Vs1A3Iure+sGWPbjY3T9ckLVp4twh4eELeA6XGLWje7yzfWXgU9qE6XQTk0X/qTVJMk1/bV3tnqvtXDWWg2lO6XKhD8JnCCrH6maSqLOtT4YVAY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67526b6-fddf-429a-8f42-08d6dd46791c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:13:26.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5982
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Chris,

Please look into this patch.

Thanks,
Shiva

> >
> > As per specification, the host can use either CMD24 or CMD25 in
> > closed-ended or open-ended way.
> > CMD25 is better option as it can flash the firmware image in one go.
> >
> > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
>=20
> Looks fine.
> Thanks,
> Avri
