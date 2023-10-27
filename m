Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465697D9CA4
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Oct 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJ0PKO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Oct 2023 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjJ0PKN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 11:10:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C418F
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698419410; x=1729955410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1pggpuI3qfiDMPg6peTM4QPPgH4FgfNwL+aWOmlfOZ0=;
  b=iLy0ZOZsakyMS+E8ZiEWXbK9FVUMgR888STwOYMkSu+72LdVR7I8pn6d
   sZ4wlupXlDgzzI8YKaF/9Jkz6yND/edNspQfP1uEMfa0IHomy/80QhlUe
   RqSAUsMCWwyyzdEw9OC2iCx8++SJZRjTSH4AxIo7rrcZmyDClV4gG8RUc
   nDf6oxgAuVtg9yWi4jw3+Bu59iOMyF61sMmTOuzMME8/lVKNg+ZX9cStE
   NA3F5J7pQEal5QV4j0XnC6Alh8S4EcwuqGfsll+bZFxRxfGcWhltScnyO
   /DodIPAJ1TTaR31FM6lVRTD05MyAchVQ4A2dCllSvPnyx0hkcqBh1JdAS
   Q==;
X-CSE-ConnectionGUID: maKL85TcQ56NFM2h5gozbw==
X-CSE-MsgGUID: 0kfhpf8lR7m8USJbIM6uhA==
X-IronPort-AV: E=Sophos;i="6.03,256,1694707200"; 
   d="scan'208";a="844686"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2023 23:10:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1259R9r0hj44BDSSj2+r5rd+r8ZJgLlRAx6xtiFffUjGcAAezUhhgxDGtfbHIgiiX28LALHlYgOOafgAOMyx/y6VktHGG0pIignOXgXLGhfbRfAoXgUe8dwU8xLGCy4Zb9gOmPgF7tiPstPI8nmIKhzmH8WfwX5EK9FuaXhviuSnKhnYNG4JeJWXC8FdcPB78RrClKZZjfh/LUykjweXsTk+55P/QIIwolrVjDgkGrraeGAxjTV0jRo1sNfq72UyZQWMSoaE5eu7r4mWTn9hVJr+RishjVsFsOUc12dn2ISil8dH23ngsFA6ISXkkkk3Bo6RpRhli1wuYdEGA3ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pggpuI3qfiDMPg6peTM4QPPgH4FgfNwL+aWOmlfOZ0=;
 b=gj4qLtUADm6+pptyABlAzY9R/+xAifcfi/WFGQoulLilQqQ2tfCtzzNXs2I4sUTL57iI41dZaGpmdRIj6fKL2JBQT0r5D5NIcHgcDie/cB1d8uW4+xwrHX/UG4hbyzQs7AxfDBayVrEzutwB/+qAA0JxBChr2BDBH/OPBV1AMGixVTsXjlpldkxDRg7iv7Mq3hukG3EYto1y4Hi5EScvrBb1k1Y/QkSYXZA6AvCjQbeamntN3ONkcMCLBo+hA9kJrpLm8AEaHWc3ODpl+EKCesLlNhGGbp6oEdVagpgLhDKG7y2y8Uc8ZJhaC4nvglVvlp6Mva2j8I6oMpSVoVY0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pggpuI3qfiDMPg6peTM4QPPgH4FgfNwL+aWOmlfOZ0=;
 b=KSCbOQnFCvbBsbzlvBwxvwM//hIPqKbQqhfr2ZWnbW/jGWXQyhEdF64QltG/f6xgNipP9lfxX4cbTB/yOWRgbdtWpmMGHIJniOdRfF0sa67Wsg6EC8E+2v6jTd6sn7zjVN4jMbR41ITKJN7kfv3tgxdIEbv6lFGrvcJXyBEcdao=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7983.namprd04.prod.outlook.com (2603:10b6:408:156::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 15:10:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6933.023; Fri, 27 Oct 2023
 15:10:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Thread-Topic: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Thread-Index: AQHaBzbqNmSV3psEX0OZ5ivOaOYF7bBbwSuAgAAUEiCAAY/fgIAAFHcAgABGfaA=
Date:   Fri, 27 Oct 2023 15:10:06 +0000
Message-ID: <DM6PR04MB65750CD4937FD290D1156AEFFCDCA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
 <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
 <DM6PR04MB6575743E1EBDC899206E9A9AFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqHV02EaSMDgLZHG51DT-smhWcc7=EvUG9+N5g7ns1HJg@mail.gmail.com>
 <77d61d32-70ee-4343-a21e-fae69d2247d7@intel.com>
In-Reply-To: <77d61d32-70ee-4343-a21e-fae69d2247d7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7983:EE_
x-ms-office365-filtering-correlation-id: 9fe3dca4-e477-4fc5-3313-08dbd6fecdf9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pe+homgjEQbtwuzPc7WDz/unwE1K1RwO1N504hL5+RrokiUFneGRPLLFtFyXHf+mJaZxDt24LkM0IHBonuf5HuikWwycf3n/wbSc/rt8b2G32lGMp5F5H2pSoabgtd+wW85QwrmuSkSUWZAxFVDXWqdJayRiaYEwPv/PUNKijZ88VLNZNCqOip5Fi4uK9B5Mx6PACgovCR1BxFFmGd7gSBNwz5GJFllf+UG0hMSwr735PEKMwKzOr887+7SJbqwHDQQe+HbpFU+9AuyOe6cRFeEbp2vWzcPxw6stbMLtOqPUuVLaNuzAAYArBsZQidwwpyCFLQQTMJjnTMOhl0ipQ7u6nKQaDBZdztRTUagRqVFhOJwEv+WUKng2FP3sWMudzg8IOy+VX7WXhd5jvVVCbYwEQEilK1QH1pReD9sefBYUSfIpZM3HK1qB9Xq1XXqkI/ASNX/LRuqlaPPD443iTLtNnIahOGCn/xyOliPYsVkXBHYTFI+oFDf7+9XzWwHjDovGxFIub99HMk19zAkCC0OVaY1Jtf+6c4pq3p3bOlYkrTv4h2HLyiDRIwmvV1UGHHwqSb02YWfoUtma5F5rg57+HnsGFHlOeeVSCok6Z7EN32KiD2CSVK9R2UR6n7Vj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(316002)(66446008)(64756008)(76116006)(66476007)(66556008)(66946007)(110136005)(54906003)(2906002)(52536014)(41300700001)(8936002)(8676002)(4326008)(478600001)(55016003)(122000001)(71200400001)(6506007)(7696005)(33656002)(83380400001)(82960400001)(9686003)(26005)(86362001)(38100700002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzFuWU9zeE9VVCtXU3Jwc1oxL0hGdUJmRVRZUXU0dUFobERxQ2wzMzU5M3lz?=
 =?utf-8?B?bTN5b2ZjMGJmVHV3cXNxYlBZTjJndmpuVnZkMjBTT1pUQjVSZE40QUc5U2Mz?=
 =?utf-8?B?SnRYMTdwYk9nb0krN29zUEpTMjlvYURHU08zSEpCMTFRazFKc05BUWd1bnM4?=
 =?utf-8?B?eWNPek9mQ0JnWkF5WWlGSXdtLzhCOHFDYzN1bGpQU3BrSnlydktPN3FldDlU?=
 =?utf-8?B?TWlBajdDWU5mRW1zRXFQV0Q0VXY2QmZWSHRrMlNrcmFMcThRaUk1VmhtK2sw?=
 =?utf-8?B?WjQraUVyMCs3QnBndnJzRG1CR01rSVRiV2hjZkpXaE95RDVjS0VXZXlSQlBp?=
 =?utf-8?B?N2JEU2ZRd1pHalpkdGIvV0JXZFhLcC9acTVhczBiejBzM0pGMDRsSTd3YUFo?=
 =?utf-8?B?NTBmK3dOM1lVdFJsVWpnVFpLb3JWUFRXWFJ4R0Z4OEx6N3A0M2ZOMTRXR0Y1?=
 =?utf-8?B?dFVDa29GVTBFZXBTZ2RURERlZmQ5SUxQc3FoVEhUYW9QOTZSL3FWeGdkemd4?=
 =?utf-8?B?YkFhV0N3UHFOSkoveEZNNW15QTJyTzloYWRsc25pOEpZNGVSbFVsRHEvZ0hM?=
 =?utf-8?B?dGR2M2tTdlpMaXlwbDczWStxVHJ2RzZQWmEyZGlITmtrekJXeU45MFVRRWI4?=
 =?utf-8?B?ei9YVTh0OXUybFFtTWw0UGVPK0U1aHkzb2lNUlJsVWFnaWhOR2NnWmFkRUQy?=
 =?utf-8?B?SWR1czdEaTRQb2tsY1hSeGhQOFB2MzBiMTlhU2hzd3U4QThBS3AxOHljY0JN?=
 =?utf-8?B?elpkenl1cmVBSmg0WGZuODZ4TkhxT0x4NDEvMHNZQkpManJsTXpOanN2WXV2?=
 =?utf-8?B?VDlXTnBsc2NZRERXQ0RrSkhQbENRT0VGK0FyMERweGUzeXBvV0dRQmw3WHhN?=
 =?utf-8?B?VURZOEhXZ1llL2RyeHBqaEdLd2lTTW80djdENlp6ZU1Ob1NCb0k5b0MwbnND?=
 =?utf-8?B?ZUdQZTZOWHpxRWszWmpvNE9ReVZmQll2OENEVngwTjNtRXMxUWdIa21FaFZs?=
 =?utf-8?B?QnFmNHhxTWxEb1FxS3YrcWtsazFPbGtNNHoxYm1mOFIrVkVIRzFmeU0rTzNF?=
 =?utf-8?B?ZHduWHd0c2ZMQ3pENFZ2anF0NHREN3JFYkVCMWJJSERGNEM2NjF6eWRUeTBG?=
 =?utf-8?B?K2dHWldEbzg2UWg1Q3RRUk56UlY1WE9rb1hQL1pQUGxYMUJ6S1dNY2YxZjBK?=
 =?utf-8?B?aW9ON1Fla05jWVdOU3hnR3hhZVBvdWgrOXU2ZEczRFNxR2VvOWtQUnJua240?=
 =?utf-8?B?OFBCWW9peHNJSkcrME5nak5QY0hVdHNkVTBxNXh6cE43NEFFVUM1Q0xzaWdM?=
 =?utf-8?B?aVoxY2dHL21peVNUTkIrdEtJRm51SFBiUkpScjNhWUhlU0JZODBKMk04YUpX?=
 =?utf-8?B?ZjU2azZBaVZJY1FzVTJKYWJYUnQxaFI2N3lJK21HajJFS29GZDdRc2c2dzlh?=
 =?utf-8?B?cktUbFBaWkZiU1BHdGNwSWJlNkpTUFgrOHhKKzM2cjh4QkJDNG9VTlFzNVk4?=
 =?utf-8?B?VVoxUXp3MmZ6bDFJZlJTSEpSR0lXWEIyL25PVUZRd09WcG90cHQzVmxqT3JJ?=
 =?utf-8?B?S2NIemNWZzNSUTA2dFRDUlNubzBQMUJ1d2JTRVJvdXZWanloSkhaRlhlQmtX?=
 =?utf-8?B?clpYNjFRUWZmQ3YxU0NNdkJmbVJJSHQxM0g5Q1p5dzE2aU01VGNXakhLWEFJ?=
 =?utf-8?B?TFF3cmd0Qi8xaXhDMWRKWFVnQVlreld2Ym5CWkMwZ0lkQm9LU3VMeWZwdE5J?=
 =?utf-8?B?aDE5eHZpdXlFZW50dU1XUVhtQmpYcStXN2RlMTA5Q291WURLdmVGb3d0aUV4?=
 =?utf-8?B?Nk9Ua21ZZS9pZXBRYVJyQW1sQWV4MDVqdzZMT0Qvekdyd1puMXVGQkJoVWdo?=
 =?utf-8?B?NzBnd0hDVFplRllWL09vNE9QZFZWZVB6YTV4d0tsMFpLRy9OVHRuek9wSWFL?=
 =?utf-8?B?dmNGbVZ3UnhHbVNseFphZWtaOVRRZlJkcThLeTZzRzVtb2wwaC9MVHlqazBv?=
 =?utf-8?B?bXYvdTg4dHAwU0g2c2dWaVM2cHF6eGE2WHdkdzRTWWFZWEUyakY2TG03UVQ2?=
 =?utf-8?B?ZkZQdTJwL29mbTdlNm1xVzRLc2o3T1VDL210S3hOZW82eE5TNWU1ZHdIUmZZ?=
 =?utf-8?Q?v02T8bbMZF7tUeP9ZyDcPHBXG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xWkuiK17x2WuZeG7uJaduSRfudKR98gKEF+BBfDej5Fm1p8xUK7qmDyKuxZ+EftnPl9rwhmdve0Gh7mzZZuoq0i9CCXV7eKUFFMtwoLp3qlZliIMwh2udJ2EtcEbFUOFWANZ31j/2gF2Eote2z5C3ld+zKV1xiB30HfrXXr8II2P52ZK/HRxqZPC1vhxB2VhkPjO0VZ68PqRIZM+3+c5Rbwe6btiUpZWTEIkaLkzcpPmCWc2oI+3GeQh6KBQPcu8S1MfzYnr+7nhDm3LPjkKp6RgR0fQ8mkMskd05JZz6KgS9aKd4J/qLkb099+qcXWTOqZWwXFLo/9eY7jHsk08o/hwfFhYBVolwCCuml4yN7bgccsFia643sjfIuMESGq0WlMWeCl0YDietJhNJDyFANDmK7ICHpjf7MR8cXc+pWb+Lm63XH7Ddh/JZ7C9m3XLeka7zQrxPFmAEGVN/cvFy2wvIq2k6DAIZICnUYy9OQI7UTvFLmo9juId8QzzB6x2KHtRdyfuO3nfuiWyNCfjb9h/NSfGkAweiEPqfyrsarOfDgCOzjzYWOKcWfqeqMSB1fLNYNJmo/2edn2qT1IVUADauFcyVRG57euI1Q5gDb0JAwxkfOb1ZJvL68PYbcUvUU+zP/6N/DvBo/KK+/Cfa58nGpDLJkf7zAyEHjXftEB+M0k/LusR5UqbXwP8B65woe7JffoaWjG4mUKcZycsf9fuklTWzEbEVIdedAcKzSzg5iukEs3fgHr12dHH9e3bS+LY1x7yODykWcIhg6I2f8j5TiD8Zo8r1NpIvqHEmFYmqCUar1HNBz7WcdD5tVJq8u3/u7iClxcUER4WJfbNdj5hND7cdtUjIpqGrzOPOeRIMDsO9MKcO1U+BdEqJ4PwVZbV9zafQTOVDv+vjkGHSw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe3dca4-e477-4fc5-3313-08dbd6fecdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 15:10:06.8490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5l9JPD7d5P317NsYuCWDSRSm9JW8fF9RBScCl2TqL/bSrdGYSLzcpPHGab73RPmT0XwT76XDb51duOFrFSOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7983
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiA+Pj4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgaXQgd291bGQgYmUgYmV0dGVyIHRvIGZpeCB0aGUg
aW9jdGwgaGFuZGxpbmcNCj4gPj4+IGFuZCBtYWtlIGl0IHVzZSBtcnEuc2JjIGluc3RlYWQgb2Yg
aXNzdWluZyBTRVRfQkxPQ0tfQ09VTlQNCj4gc2VwYXJhdGVseS4NCj4gPj4gV2UgY2FuIGRvIHRo
YXQuDQo+ID4+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGlzIGRvZXNuJ3QgaGFwcGVuIG9uIG90aGVy
IHBsYXRmb3Jtcy4NCj4gPj4gRnd1cGQgaGFzIGp1c3QgcmVjZW50bHkgc3dpdGNoZWQgdG8gY2xv
c2UtZW5kZWQsIGJ1dCBtbWMtdXRpbHMgaXMNCj4gPj4gdXNpbmcgY2xvc2UtZW5kZWQgbW9kZSBm
b3IgbWFueSB5ZWFycywgUGVyZm9ybWluZyBmZnUgc3VjY2Vzc2Z1bGx5IG9uDQo+IG1hbnkgZGlm
ZmVyZW50IHBsYXRmb3Jtcy4NCj4gPj4gTXkgdW5kZXJzdGFuZGluZyBpcywgdGhhdCB0aGUgaHcg
c2hvdWxkIHJlYWxpemUgdGhhdCBjbWQyMyBoYXMganVzdCBzZW50DQo+IHByaW9yIHRvIGNtZDI1
IGFuZCBhdm9pZCB0aGlzIGF1dG8tY21kMTIuDQo+ID4NCj4gPiBZZXMsIGluIHByaW5jaXBsZSB0
aGF0J3MgY29ycmVjdC4NCj4gPg0KPiA+IEluIGZhY3QsIEkgdGhpbmsgdGhhdCBtb3N0IGhvc3Qg
ZHJpdmVycyBzaG91bGQgYWxyZWFkeSBzdXBwb3J0IHRoaXMNCj4gPiBiZWhhdmlvciwgYWx0aG91
Z2ggaXQgcmVsaWVzIG9uIHRoZSBDTUQyMyB0byBiZSBpbmNvcnBvcmF0ZWQgd2l0aGluDQo+ID4g
dGhlIHNhbWUgbW1jIHJlcXVlc3QgKG1ycSkgYXMgdGhlIENNRDI1LiBXZSB1c2UgIm1ycS5zYmMi
IGZvciB0aGlzIGFuZA0KPiA+IHRoZSBob3N0IGRyaXZlciB1c2VzIE1NQ19DQVBfQ01EMjMgdG8g
aW5mb3JtIHRoZSBNTUMgY29yZSB3aGV0aGVyIGl0DQo+ID4gc3VwcG9ydHMgdGhpcyBvciBub3Qu
DQo+ID4NCj4gPj4NCj4gPj4gR29pbmcgYmFjayB0byB5b3VyIHByb3Bvc2FsLCB3ZSBjYW4gaWdu
b3JlIGNtZDIzIGluIGNsb3NlLWVuZGVkIGZmdSwNCj4gPj4gYnV0IGV2ZW50dWFsbHksIHdlIHdp
bGwgbmVlZCB0byBjaGFuZ2UgbW1jLXV0aWxzIGFuZCBmd3VwZCB0byBzdG9wIHNlbmQNCj4gY21k
MjMuDQo+ID4NCj4gPiBUaGlzIGlzIG5vdCB3aGF0IHdlIHByb3Bvc2VkLCBhdCBsZWFzdCBpZiBJ
IHVuZGVyc3Rvb2QgQWRyaWFuIGNvcnJlY3RseS4NCj4gPg0KPiA+IEluc3RlYWQsIHRoZSBpZGVh
IHRoYXQgY291bGQgbWFrZSBiZXR0ZXIgc2Vuc2UsIGlzIHRvIGZpeCB0aGUgbW1jDQo+ID4gaW9j
dGwgaGFuZGxpbmcgaW4gdGhlIG1tYyBjb3JlLCBzbyB0aGF0IGl0IGNhbiBkaXNjb3ZlciB0aGF0
IGEgQ01EMjMNCj4gPiBjb21tYW5kIGlzIGZvbGxvd2VkIGJ5IGFub3RoZXIgQ01EMTgvMjUgKG11
bHRpcGxlIHJlYWQvd3JpdGUpLiBBbmQgaW4NCj4gPiB0aGlzIGNhc2UsIGl0IHNob3VsZCBib3Vu
ZGxlIHRoZSBjb21tYW5kcyB0b2dldGhlciwgdXNpbmcgbXJxLnNiYyBzbw0KPiA+IHRoYXQgb25l
IHJlcXVlc3QgZ2V0cyBzZW50IHRvIHRoZSBtbWMgaG9zdCBkcml2ZXIgaW5zdGVhZCBvZiB0d28u
DQo+IA0KPiBZZXMgdGhhdCBpcyB3aGF0IEkgd2FzIHRoaW5raW5nLiAgUGVyaGFwcyBsb29rIGF0
DQo+IF9fbW1jX2Jsa19pb2N0bF9jbWQoKSBmaXJzdC4gIEl0IGRvZXNuJ3QgaGF2ZSBlbm91Z2gg
aW5mb3JtYXRpb24gdG8gZGVjaWRlDQo+IHdoYXQgdG8gZG8sIHNvIGVpdGhlciBzb21ldGhpbmcg
bmVlZHMgdG8gYmUgYWRkZWQgdG8gc3RydWN0DQo+IG1tY19ibGtfaW9jX2RhdGEgYW5kIHNldCB1
cCBiZWZvcmUgaGFuZCwgb3IgaXQgbmVlZHMgdG8gYmUgcGFzc2VkIHN0cnVjdA0KPiBtbWNfcXVl
dWVfcmVxICptcV9ycS4NCk9LLiBUaGFua3MuDQpXaWxsIHdvcmsgc29tZXRoaW5nIG91dCBhbmQg
c2VuZCBhIG5ldyBzZXJpZXMgbmV4dCB3ZWVrLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+ID4N
Cj4gPiBJbiB0aGlzIHdheSwgdGhlcmUgc2hvdWxkIGJlIG5vIG5lZWQgZm9yIGFueSBzcGVjaWZp
YyBjaGFuZ2VzIHRvIGFueQ0KPiA+IG9mIHRoZSBob3N0IGRyaXZlcnMgKGFzc3VtaW5nIHRoZXkg
aGF2ZSB0aGUgQ01EMjMgc3VwcG9ydCBpbXBsZW1lbnRlZA0KPiA+IGNvcnJlY3RseSksIHRoZXkg
c2hvdWxkIGp1c3Qgd29yay4NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMN
Cj4gPiBVZmZlDQoNCg==
