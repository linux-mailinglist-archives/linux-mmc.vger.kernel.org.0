Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A777402D7
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Jun 2023 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjF0SJ6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Jun 2023 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjF0SJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2023 14:09:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2124.outbound.protection.outlook.com [40.107.114.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621010C9;
        Tue, 27 Jun 2023 11:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWWhmOurmD5We1OpkAO5wHVZNjcULzgc8JPAydKju8vqqHQg6qy+z9nDBww+LhOBG0DMhDR/EadW4UgXUYlWArAGrpv/9gTvczRFF2Kh8BQEIHff8Ps3Vlk8b4wUnqnpwGOs24Y+Hmk0W9nc4cWJ935fbTA1c1oHBXj+VEAFYZ2MZqK2YbRQqcf0Bznj+64GdDN6e4+y/kVxHrgAMUBRfOtv8aMOYp5o5z+H6KKdJoV31CEk44cYmWCgtQoIE77wRERW6WJTMSVbuAOdGnysNFMFsCosMRVWKh9lipddllgU5IF/1HouGzLNRoe5QwD8MmcvD7idVV19pzSKK++J8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi5xdr/kQD6sCKKyXXEBXSMjBo4QttZHogFol+idyik=;
 b=b9BEgSDjLiG4zgOm798L5BNRFStdFZFO1fXjbrJ6JdUboY+OK/+MIn1+QOZUiMS6lC4cxCFYaGqIyCnxk2ALeZQCFd7Lly3AxP4E2VaVCYRFYY5dmvKuV1bq0b/BmSKoFlFxilYJ3v2OzdUrpeGvRJopcTzYp4sui04BdZywk8gfMArJneFx6LwnhjIjymsVnYDSv268DCiUd0UE3kdTL1H4y/1SMZSlZdPGS8h8brhGZsuXv0o4RvIFZfSHXo+Mi7AZD4IaD2Fh3R0XtWHjIpEoUnr6qHb/3VojVzk3uPm6/AML5n3T2EjW00fw/mo+L90lKRfeSPdIrFlTXnDrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi5xdr/kQD6sCKKyXXEBXSMjBo4QttZHogFol+idyik=;
 b=TlE7dTB2+NRJZEgPeihphOyIpUDI1nON7hQ4mD/IdewiWjUocxoiTMxcV0XCA0NwlcJDkL5YRM2gGgpFtq0OqtFtrQTr7qd554eQFvWJen/yEXP9oUPwd8l4dSRT8OVQGDsw42Y5XS0Anix8/34cGBir5nKC7e3M8ESw4h0QCEU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7942.jpnprd01.prod.outlook.com (2603:1096:400:187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 18:09:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:09:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dennis Zhou <dennis@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Thread-Topic: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Thread-Index: AQHZqRupg6JV0xX/XkyUwi960DwKDK+e8fDg
Date:   Tue, 27 Jun 2023 18:09:49 +0000
Message-ID: <OS0PR01MB59229572D27D06F916D251378627A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
In-Reply-To: <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7942:EE_
x-ms-office365-filtering-correlation-id: 6753b393-761f-45d2-73a5-08db7739b2c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVwNDCN3UMWXG7wP1ra0dVYBCughRxZp1JTI9l69Zc9HAYqFJJfAtFI2Zc2KwZTd1tJkUbGuUuHL8/8WoVrtR18U+Qe2e5qd68LZhF/LTLNlPKxMP/5m2iSCZOnqJpwMvsq+uK6iIy98fHZ+D7Ca035FJx3edAEZfu1hXJcMxTfF0WRlsUp9d1ilLwR9iPkibc94qXhWqu/seL/VS7BGFFX/QQK+pDV6eSqB6vfhrE1lp7IAZL+jELCsaBhU948MUWl8erncMLpYkFjvuyIYTFCIIteZBS0FPsaz2RAa8kHdHd3x1pqB95RDrwnuF14MLjlqrZxjV4V1axo+PQ4FK1BAVThiEtcY1EdKdCio/5sfCmdhqBYHLdM2tAN1fzEaw+grVHggDWUJurjJomoMGR4/TtrG+Tw/wafIfJ1Vmut4ff6cf++UsvuYhRBqRDangh44ieFSyTvcebfdFARpSVKKcvOV6eOI9bd/bZSbrq0qhPekliGLOpum2q+Tf0m7mbp47+yx7aV0KVLgKg0fb6ymN4AR6Xu8XokkIvmH5WUehDOrFr8i5Hs3gvewzdfv56U3M683TG6PPshCWpuccjmNXtKjQgeLc1nWmd7X78wBJt2eKvTWgNt2V51NZOub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(83380400001)(7696005)(110136005)(54906003)(478600001)(9686003)(33656002)(53546011)(66556008)(2906002)(66946007)(26005)(186003)(71200400001)(66476007)(64756008)(66446008)(6506007)(316002)(41300700001)(76116006)(38100700002)(8676002)(5660300002)(52536014)(4326008)(8936002)(122000001)(55016003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUcxQ0YyR1R0RFdoMGZRUUU2elhIYTUxd3B2aFp4NDFlTjNYK3B2dTVOdmVY?=
 =?utf-8?B?ejJKSUt6WTgyZEhqWGl6cFdiVjl6Mmh0MGl6NkIvVzZOWkJiR1liaGt4Tzdl?=
 =?utf-8?B?cC9JMkNYelIwMUZIeU5yZDgvZWU1RkQzZGNmNkZtaHN3YW1ueG9TVTg5TzMr?=
 =?utf-8?B?OThNZFNmSTBrSHhnUTgyWmlKNG9wMTBlS1M5aVFvcnBnS29BVVkyOGRNM2tM?=
 =?utf-8?B?bU9lQzRNdDloMzY0S2hkZFNlWjNxWmJyN1JlZUNtRjVJWHkwOHRmcmZkRTZm?=
 =?utf-8?B?a1dZTzdBT3J1SHUrM2FiQWNPQU5qSmhqNElENkRJWXFRd1dPNDVZVXkrUjkv?=
 =?utf-8?B?MXlTczlHclRvaWhMeHB3Ym9FWG5KVXFKVXpMZDJ4WDlCVGxhUW4xMFV6aEV0?=
 =?utf-8?B?R3crWHRCWXhncC9WU2JROC9sQlFCaU5Ib1htZUE0QzZSZSthVFVCVEYrbVFE?=
 =?utf-8?B?MlY1bHNJU2IwdmpNWXVJWFdMUzBqdk9CNDFUOGF6QWhxNGwwYXYzd0hNYkRn?=
 =?utf-8?B?ODFXZEcxK1hzTjFqVXI5bUJyRHNxQ3Zad1ZCVDRaVXhoNitwZ1dZNUdlZWVz?=
 =?utf-8?B?dTJ1aWRFMTloOUdoTjlCRDkvWnZETHJrOEQrc3BjRTFjZWlSV2RDbE1yWW1V?=
 =?utf-8?B?MERJbnowWkZNdHNXWVNQMVV4dFkxNVhpQ1hmOEwxanhzV0dvTG9RYnVCdjla?=
 =?utf-8?B?eFVXaCt2anhIbzZyb01rNFBtSm9tMGlXR0wycHNuMEk5YURpZzIxbTBWWmVo?=
 =?utf-8?B?SDdLSU9RamxYMHQ3OVdqVnpBallSanpyYlUzQ1VMdE41ekUwbUFlMU5ST0ZZ?=
 =?utf-8?B?dXpwRndYOXlBRERTdWhKUmx0UEpNRXZaVzliY1ZHdHg5Vm1aNjJqRVpXL3kr?=
 =?utf-8?B?MlczWlFvRGlWL0xobnhkaXRBbERxWVdvWVBlVTV1Q2FiSWQ3bWJlRFBXZUk3?=
 =?utf-8?B?Q0FzblB0eXFkcDRBZVhFUEpBWE9aWGVUaERUeGRGRVkwSnRaVFJaMFJyZEtz?=
 =?utf-8?B?YTNxTjFYN2pVM29hRG95c1F2a3BZTFRLWk1JbXM5aHQyUkhBZWprNkt6c1RQ?=
 =?utf-8?B?TTNOc2lsR0N6T1orNTBUZUFvaWE3NkxlNk0wT25wQmFycGQ5c2NBK3BPUzJE?=
 =?utf-8?B?MUMwQmJwbWFLQ0l0SnZtQjBEdXZFWStxNVhEMXJ0UUN0by9RSlQwR2VKRXYr?=
 =?utf-8?B?TktTR2N5T1hpdm10R3IrZFFhRDUrSWRlZ0VqMVhJbUNzUEJGV2hDa2N3eDht?=
 =?utf-8?B?cnNHUEFES0FacmRNU2JBeGd5d0dzKzZLdGZRc1IwcG9WTnQ0Ykx6ZkZoZ21q?=
 =?utf-8?B?TnV5SUNzMitMQWV0UElpazlWZW9nVi9TSVZ4YnIxYXlrOHVMNWJQNHU3b1I3?=
 =?utf-8?B?QlYvZnkySDJqTTE1bG43VFp3RU5OVEhueURuQzdzUmZiRXV1Ui95bytKK09Q?=
 =?utf-8?B?VmhMYUZjZ280QkpGMk1PUzBGbTRwWWFLSk5nZGlrV2d3cFZzNlRwT3VyVGFY?=
 =?utf-8?B?NFRWU2VTcFphRnp4SWx4QnFZcTRnYkpCVGRUWEtVdDl4TWNRUlNSZC9CeVp4?=
 =?utf-8?B?bmZNZjV5Mmp6OGFmMDNWM0w1MFpNcFd1VjFNaGlUSzl5ZmFzdXJtM2kzcDcw?=
 =?utf-8?B?SE91Qy80UlpoYkVFYkF4MjVGZVZIelBsZE92b2NJeUUyb1JsR0pJWFJCM0c3?=
 =?utf-8?B?cTFOME14cDh3VVROWTFjKzh0WGljYk90OE5ibVdCZXpPWXl4TDlGMmFOY1Jl?=
 =?utf-8?B?S1lHbHIydDJjbzVZN0kwc3EvZzNHZGpKVExRd3QxT3VNTmJhd3pFTGNBWjA5?=
 =?utf-8?B?d3pSZFhmYlB4SEJQdnVpUFdmeHdFbHZxZkI1M3pnaFprSEl2QlMrTzF6Tms5?=
 =?utf-8?B?ekF1M00zV1d1UzRwN2c2Q1UxZFFZS3oyVmFQcWtzbEhBTEo0dE1MUlhpSnhW?=
 =?utf-8?B?MnFXblV3UHR2UldKZkpUS0sxdHN6MDdRaENHcTN4ZHpyUWltNGxHUkQ5dmR1?=
 =?utf-8?B?RnNjN2ZxeUZIL2VZajJmMlBMMjAxM1hPdmZvcUdIbXp2em1hYit4d3pKMWNx?=
 =?utf-8?B?Zmg3S0FZL3NwSlhDSW82ZzBGOFQ1Tkg5a05aRElFZ2lQbUY1VXpHRUpCOE16?=
 =?utf-8?Q?L6bj5LWYYcBmg1PLQSz10yzP2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753b393-761f-45d2-73a5-08db7739b2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 18:09:49.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hipTx9T9iTsCYNju76e5JMC9xaexpEjUp/KhfoihRPtqGOVism4GZU9KMyzLgm8CoUHGv40nIPEBDYgkDHEwMPJrbKvn1vTye/7wTF8HEpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7942
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgRGVubmlzLA0KDQpSZXZlcnRpbmcgY29tbWl0IDJjYzgzYmY3ZDQxMTEzZDkgKCJtbWM6Y29y
ZTogQWxsb3cgbW1jX3N0YXJ0X2hvc3QoKSBzeW5jaHJvbm91c2x5IGRldGVjdCBhIGNhcmQiKSBm
aXhlcyBiZWxvdyBpc3N1ZVsxXSBvbiBSWi9HMkwgU01BUkMgRVZLIHRvby4NCg0KWzFdIEJlZm9y
ZSByZXZlcnRpbmc6DQotLS0tLS0tLS0tLS0tLS0tLS0NCg0KWyAgICAyLjQ2OTI2Nl0gcmVuZXNh
c19zZGhpX2ludGVybmFsX2RtYWMgMTFjMTAwMDAubW1jOiBtbWMxIGJhc2UgYXQgMHgwMDAwMDAw
MDExYzEwMDAwLCBtYXggY2xvY2sgcmF0ZSAxMzMgTUh6DQpbICAgIDIuOTkzMTEyXSBtbWMxOiBu
ZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFIxMDQgU0RIQyBjYXJkIGF0IGFkZHJlc3MgYWFhYQ0KWyAg
ICAzLjAxNDA1Ml0gbW1jYmxrMTogbW1jMTphYWFhIFNDMzJHIDI5LjcgR2lCDQpbICAgIDMuMDMz
ODI2XSAgbW1jYmxrMTogcDENClsgICAgNy42NTE0NDddIHJlbmVzYXNfc2RoaV9pbnRlcm5hbF9k
bWFjIDExYzAwMDAwLm1tYzogdGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQg
KENNRDUyKQ0KWyAgIDEyLjc2ODExOF0gcmVuZXNhc19zZGhpX2ludGVybmFsX2RtYWMgMTFjMDAw
MDAubW1jOiB0aW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGludGVycnVwdCAoQ01ENTIpDQpb
ICAgMTcuODg4MjQwXSByZW5lc2FzX3NkaGlfaW50ZXJuYWxfZG1hYyAxMWMwMDAwMC5tbWM6IHRp
bWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0IChDTUQwKQ0KWyAgIDIzLjAwODEy
Ml0gcmVuZXNhc19zZGhpX2ludGVybmFsX2RtYWMgMTFjMDAwMDAubW1jOiB0aW1lb3V0IHdhaXRp
bmcgZm9yIGhhcmR3YXJlIGludGVycnVwdCAoQ01EOCkNClsgICAyOC4xMjgwOThdIHJlbmVzYXNf
c2RoaV9pbnRlcm5hbF9kbWFjIDExYzAwMDAwLm1tYzogdGltZW91dCB3YWl0aW5nIGZvciBoYXJk
d2FyZSBpbnRlcnJ1cHQgKENNRDUpDQpbICAgMzMuMjQ4MTE1XSByZW5lc2FzX3NkaGlfaW50ZXJu
YWxfZG1hYyAxMWMwMDAwMC5tbWM6IHRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgaW50ZXJy
dXB0IChDTUQ1KQ0KWyAgIDM4LjM2ODExOV0gcmVuZXNhc19zZGhpX2ludGVybmFsX2RtYWMgMTFj
MDAwMDAubW1jOiB0aW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGludGVycnVwdCAoQ01ENSkN
ClsgICA0My40ODgxMTJdIHJlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFjIDExYzAwMDAwLm1tYzog
dGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQgKENNRDUpDQpbICAgNDguNjA4
MTEwXSByZW5lc2FzX3NkaGlfaW50ZXJuYWxfZG1hYyAxMWMwMDAwMC5tbWM6IHRpbWVvdXQgd2Fp
dGluZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0IChDTUQ1NSkNClsgICA1My43MjgxMjFdIHJlbmVz
YXNfc2RoaV9pbnRlcm5hbF9kbWFjIDExYzAwMDAwLm1tYzogdGltZW91dCB3YWl0aW5nIGZvciBo
YXJkd2FyZSBpbnRlcnJ1cHQgKENNRDU1KQ0KWyAgIDU4Ljg0ODExNV0gcmVuZXNhc19zZGhpX2lu
dGVybmFsX2RtYWMgMTFjMDAwMDAubW1jOiB0aW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGlu
dGVycnVwdCAoQ01ENTUpDQpbICAgNjMuOTY4MTE4XSByZW5lc2FzX3NkaGlfaW50ZXJuYWxfZG1h
YyAxMWMwMDAwMC5tbWM6IHRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0IChD
TUQ1NSkNCg0KQWZ0ZXIgcmV2ZXJ0aW5nOg0KLS0tLS0tLS0tLS0tLS0NClsgICAgMi40NjMxMTJd
IHJlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFjIDExYzEwMDAwLm1tYzogbW1jMSBiYXNlIGF0IDB4
MDAwMDAwMDAxMWMxMDAwMCwgbWF4IGNsb2NrIHJhdGUgMTMzIE1Ieg0KWyAgICAyLjQ3MjU2OV0g
cnotc3NpLXBjbS1hdWRpbyAxMDA0OWMwMC5zc2k6IERNQSBlbmFibGVkDQpbICAgIDIuNDc0MTI0
XSByZW5lc2FzX3NkaGlfaW50ZXJuYWxfZG1hYyAxMWMwMDAwMC5tbWM6IG1tYzAgYmFzZSBhdCAw
eDAwMDAwMDAwMTFjMDAwMDAsIG1heCBjbG9jayByYXRlIDEzMyBNSHoNClsgICAgMi42MDAwNTBd
IG1tYzA6IG5ldyBIUzIwMCBNTUMgY2FyZCBhdCBhZGRyZXNzIDAwMDENClsgICAgMi42MDg5MzFd
IG1tY2JsazA6IG1tYzA6MDAwMSBHMU0xNU0gNTkuMyBHaUINClsgICAgMi42MjM0MzJdICBtbWNi
bGswOiBwMQ0KWyAgICAyLjYyOTg2M10gbW1jYmxrMGJvb3QwOiBtbWMwOjAwMDEgRzFNMTVNIDMx
LjUgTWlCDQpbICAgIDIuNjQwMDA4XSBtbWNibGswYm9vdDE6IG1tYzA6MDAwMSBHMU0xNU0gMzEu
NSBNaUINClsgICAgMi42NTAyMTJdIG1tY2JsazBycG1iOiBtbWMwOjAwMDEgRzFNMTVNIDQuMDAg
TWlCLCBjaGFyZGV2ICgyNDI6MCkNClsgICAgMi42ODE2MDldIE1pY3JvY2hpcCBLU1o5MTMxIEdp
Z2FiaXQgUEhZIDExYzIwMDAwLmV0aGVybmV0LWZmZmZmZmZmOjA3OiBhdHRhY2hlZCBQSFkgZHJp
dmVyIChtaWlfYnVzOnBoeV9hZGRyPTExYzIwMDAwLmV0aGVybmV0LWZmZmZmZmZmOjA3LCBpcnE9
NTQpDQpbICAgIDMuMDIwMDg1XSBtbWMxOiBuZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFIxMDQgU0RI
QyBjYXJkIGF0IGFkZHJlc3MgYWFhYQ0KWyAgICAzLjAzMzA3OV0gbW1jYmxrMTogbW1jMTphYWFh
IFNDMzJHIDI5LjcgR2lCDQpbICAgIDMuMDQ4NDAyXSAgbW1jYmxrMTogcDENCg0KQ2hlZXJzLA0K
QmlqdQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjcs
IDIwMjMgNjoyMCBQTQ0KPiBUbzogRGVubmlzIFpob3UgPGRlbm5pc0BrZXJuZWwub3JnPg0KPiBD
YzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBMaW51eCBNTUMgTGlzdCA8
bGludXgtDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT47IFdvbGZyYW0NCj4gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdp
bmVlcmluZy5jb20+OyBMaW51eC1SZW5lc2FzIDxsaW51eC1yZW5lc2FzLQ0KPiBzb2NAdmdlci5r
ZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtbWM6IGlubGluZSB0aGUgZmly
c3QgbW1jX3NjYW4oKSBvbg0KPiBtbWNfc3RhcnRfaG9zdCgpDQo+IA0KPiBIaSBEZW5uaXMsDQo+
IA0KPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAxOjQ44oCvQU0gRGVubmlzIFpob3UgPGRlbm5p
c0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiBXaGVuIHVzaW5nIGRtLXZlcml0eSB3aXRoIGEgZGF0
YSBwYXJ0aXRpb24gb24gYW4gZW1tYyBkZXZpY2UsDQo+ID4gZG0tdmVyaXR5IHJhY2VzIHdpdGgg
dGhlIGRpc2NvdmVyeSBvZiBhdHRhY2hlZCBlbW1jIGRldmljZXMuIFRoaXMgaXMNCj4gPiBiZWNh
dXNlIG1tYydzIHByb2JpbmcgY29kZSBzZXRzIHVwIHRoZSBob3N0IGRhdGEgc3RydWN0dXJlIHRo
ZW4gYSB3b3JrDQo+ID4gaXRlbSBpcyBzY2hlZHVsZWQgdG8gZG8gZGlzY292ZXJ5IGFmdGVyd2Fy
ZHMuIFRvIHByZXZlbnQgdGhpcyByYWNlIG9uDQo+ID4gaW5pdCwgbGV0J3MgaW5saW5lIHRoZSBm
aXJzdCBjYWxsIHRvIGRldGVjdGlvbiwgX19tbV9zY2FuKCksIGFuZCBsZXQNCj4gPiBzdWJzZXF1
ZW50IGRldGVjdCBjYWxscyBiZSBoYW5kbGVkIHZpYSB0aGUgd29ya3F1ZXVlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRGVubmlzIFpob3UgPGRlbm5pc0BrZXJuZWwub3JnPg0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIHBhdGNoLCB3aGljaCBpcyBub3cgY29tbWl0IDJjYzgzYmY3ZDQxMTEzZDkg
KCJtbWM6DQo+IGNvcmU6IEFsbG93IG1tY19zdGFydF9ob3N0KCkgc3luY2hyb25vdXNseSBkZXRl
Y3QgYSBjYXJkIikgaW4gbGludXgtDQo+IG5leHQvbWFzdGVyIG1tYy9uZXh0IG5leHQtMjAyMzA2
MTQgbmV4dC0yMDIzMDYxNSBuZXh0LTIwMjMwNjE2DQo+IA0KPiBJIGhhdmUgYmlzZWN0ZWQgdGhl
IGZvbGxvd2luZyBmYWlsdXJlIG9uIFJlbmVzYXMgU2FsdmF0b3ItWFMgd2l0aCBSLUNhcg0KPiBI
Mw0KPiBFUzIuMCB0byB0aGUgYWJvdmUgY29tbWl0Og0KPiANCj4gICAgIHJlbmVzYXNfc2RoaV9p
bnRlcm5hbF9kbWFjIGVlMTQwMDAwLm1tYzogdGltZW91dCB3YWl0aW5nIGZvcg0KPiBoYXJkd2Fy
ZSBpbnRlcnJ1cHQgKENNRDApDQo+ICAgICByZW5lc2FzX3NkaGlfaW50ZXJuYWxfZG1hYyBlZTE0
MDAwMC5tbWM6IHRpbWVvdXQgd2FpdGluZyBmb3INCj4gaGFyZHdhcmUgaW50ZXJydXB0IChDTUQx
KQ0KPiAgICAgcmVuZXNhc19zZGhpX2ludGVybmFsX2RtYWMgZWUxNDAwMDAubW1jOiB0aW1lb3V0
IHdhaXRpbmcgZm9yDQo+IGhhcmR3YXJlIGludGVycnVwdCAoQ01EMCkNCj4gICAgIHJlbmVzYXNf
c2RoaV9pbnRlcm5hbF9kbWFjIGVlMTQwMDAwLm1tYzogdGltZW91dCB3YWl0aW5nIGZvcg0KPiBo
YXJkd2FyZSBpbnRlcnJ1cHQgKENNRDEpDQo+ICAgICBtbWMwOiBGYWlsZWQgdG8gaW5pdGlhbGl6
ZSBhIG5vbi1yZW1vdmFibGUgY2FyZA0KPiANCj4gUmV2ZXJ0aW5nIHRoZSBjb21taXQgZml4ZXMg
dGhlIGlzc3VlIGZvciBtZS4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+IEBAIC0yMTg1LDEwICsyMTg1
LDggQEAgaW50IG1tY19jYXJkX2FsdGVybmF0aXZlX2dwdF9zZWN0b3Ioc3RydWN0DQo+ID4gbW1j
X2NhcmQgKmNhcmQsIHNlY3Rvcl90ICpncHRfc2VjdG9yKSAgfQ0KPiA+IEVYUE9SVF9TWU1CT0wo
bW1jX2NhcmRfYWx0ZXJuYXRpdmVfZ3B0X3NlY3Rvcik7DQo+ID4NCj4gPiAtdm9pZCBtbWNfcmVz
Y2FuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiArc3RhdGljIHZvaWQgX19tbWNfcmVz
Y2FuKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gPiAgew0KPiA+IC0gICAgICAgc3RydWN0IG1t
Y19ob3N0ICpob3N0ID0NCj4gPiAtICAgICAgICAgICAgICAgY29udGFpbmVyX29mKHdvcmssIHN0
cnVjdCBtbWNfaG9zdCwgZGV0ZWN0LndvcmspOw0KPiA+ICAgICAgICAgaW50IGk7DQo+ID4NCj4g
PiAgICAgICAgIGlmIChob3N0LT5yZXNjYW5fZGlzYWJsZSkNCj4gPiBAQCAtMjI0OSw2ICsyMjQ3
LDE0IEBAIHZvaWQgbW1jX3Jlc2NhbihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gICAg
ICAgICAgICAgICAgIG1tY19zY2hlZHVsZV9kZWxheWVkX3dvcmsoJmhvc3QtPmRldGVjdCwgSFop
OyAgfQ0KPiA+DQo+ID4gK3ZvaWQgbW1jX3Jlc2NhbihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
IHsNCj4gPiArICAgICAgIHN0cnVjdCBtbWNfaG9zdCAqaG9zdCA9DQo+ID4gKyAgICAgICAgICAg
ICAgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgbW1jX2hvc3QsIGRldGVjdC53b3JrKTsNCj4g
PiArDQo+ID4gKyAgICAgICBfX21tY19yZXNjYW4oaG9zdCk7DQo+ID4gK30NCj4gPiArDQo+ID4g
IHZvaWQgbW1jX3N0YXJ0X2hvc3Qoc3RydWN0IG1tY19ob3N0ICpob3N0KSAgew0KPiA+ICAgICAg
ICAgaG9zdC0+Zl9pbml0ID0gbWF4KG1pbihmcmVxc1swXSwgaG9zdC0+Zl9tYXgpLCBob3N0LT5m
X21pbik7DQo+ID4gQEAgLTIyNjEsNyArMjI2Nyw4IEBAIHZvaWQgbW1jX3N0YXJ0X2hvc3Qoc3Ry
dWN0IG1tY19ob3N0ICpob3N0KQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBtbWNf
Z3Bpb2RfcmVxdWVzdF9jZF9pcnEoaG9zdCk7DQo+ID4gLSAgICAgICBfbW1jX2RldGVjdF9jaGFu
Z2UoaG9zdCwgMCwgZmFsc2UpOw0KPiA+ICsgICAgICAgaG9zdC0+ZGV0ZWN0X2NoYW5nZSA9IDE7
DQo+ID4gKyAgICAgICBfX21tY19yZXNjYW4oaG9zdCk7DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lk
IF9fbW1jX3N0b3BfaG9zdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQo+IA0KPiBHcntvZXRqZSxl
ZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0K
PiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMy
IC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0
aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1
dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIi
IG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
