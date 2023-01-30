Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A82680854
	for <lists+linux-mmc@lfdr.de>; Mon, 30 Jan 2023 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjA3JRH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 30 Jan 2023 04:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjA3JRG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 04:17:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BF166D4
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 01:17:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so29788593ejc.4
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fsyHauj9EOBike+C7FSiVRVwoEoNyRE7eOJ4tqUZH+c=;
        b=CKXxvhOn54xPoOI0DshmAvKhi4MpVt94GFWWN9ceF6WZ5gdKH5Od7U7KwECDkaMlGn
         pgOybDLuinmjLcY2DaMWDteqGFxYDJ51YgUU4ybHejVh5asfIt25kWJGxuvf0XBhOw2p
         5IrGPGNDfjOw3B0kXzk2tHgkzFw/miCFYSROaUX0gx2CTU2fvYnaHHY/NVep+ey5+1uj
         WpgRBdL44VkczZkTtLbcZedOOFJ5FTnTjBK9VW0KYh60ZwCU/r9NxosGWYNGX8b1SA4J
         eNif+qh0L5wE/mBSHOtGuvHJK5vm2m5h9eamiRoMf8ldjdlVnKPKOY9jFhWnr/I/7RDh
         VOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsyHauj9EOBike+C7FSiVRVwoEoNyRE7eOJ4tqUZH+c=;
        b=NAx+DgRGya/QQIIHoY5jcZ2gLxTvzDXlUiP06TKCxhMwAiM2BYnAP+VQeytkJ8pCf4
         DPi4YKWk61vT3T4CzHjJ7PT6f9aT/YLy7QAoYK79XsWtuk1hMBZWFRrHqH+uKqhfVCPr
         fLs43WJoAncNEQZytd9rHSB8upebv5Qk7Vl3zTxdeBIe2s63gBI0bBREe9IsBUUzRKIP
         NNc5/8XADhIKyoV/wQ0B6QF+SQpT6z99OkD7bFJdJn2LzADgSVFl8ZIscZ6J/e49gllc
         /OLOd5jw4jty+Z6eP8A6CWc/mRWsgtwsejUSCHqgXqWU13a6pnHrykuc1kdd8ZQslGVA
         a30Q==
X-Gm-Message-State: AFqh2kqDMey3CMWY9iqfKJspr0MoDejDLEOLR11f4+EXUXUKcasMdqOE
        ujgcOB0BQfur/C6WUk0LixN+t8LUM2nzwLipSI0=
X-Google-Smtp-Source: AMrXdXv9C9IOCymPc19lv6l0wNSrhPrXSBvuKVx1p6VED7Bfq86CfmyxZ6WzG+dQI1CYmX0z/561bUnpRAOzMn3OVaE=
X-Received: by 2002:a17:906:c283:b0:835:57c9:6432 with SMTP id
 r3-20020a170906c28300b0083557c96432mr7376616ejz.254.1675070222928; Mon, 30
 Jan 2023 01:17:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7412:d08c:b0:8f:e183:fcc3 with HTTP; Mon, 30 Jan 2023
 01:17:02 -0800 (PST)
Reply-To: cristinacampel@outlook.com
From:   "Mrs. Cristina Campbell" <cristiinacampbell@gmail.com>
Date:   Mon, 30 Jan 2023 09:17:02 +0000
Message-ID: <CAKd_V8Zar+VEfJRcDND5P1PQQkV7VmnApyuWNiKHcjyQG5qiJQ@mail.gmail.com>
Subject: me puedes ayudar
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cristiinacampbell[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Querido amado,

Soy la Sra. Cristina Campbell de Londres, Reino Unido. Hay algo serio
de lo que debemos hablar. Si no est=C3=A1 demasiado ocupado, responda a mi
correo personal que es (cristinacampel@outlook.com) para que pueda
brindarle m=C3=A1s informaci=C3=B3n. este proyecto de caridad humanitaria e=
n su
pa=C3=ADs por valor de Seis Millones de D=C3=B3lares Estadounidenses
$6,000,000.00 usd.

Atentamente.
Sra. Cristina Campbell
Correo electr=C3=B3nico; cristinacampel@outlook.com
