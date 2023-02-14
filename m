Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517169709B
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Feb 2023 23:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjBNWSP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 14 Feb 2023 17:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBNWSK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 17:18:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BD22026
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 14:18:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qb15so41576350ejc.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNrKKIEifKOtj0ZTyaBn9IXYDH+TgIsaibPuySrCl9A=;
        b=NXJWQlVXdExWigaYiVmHP67AJwtobiv0bNA7KQ3Il7g6RaNU8h/JRHfIO3wtRXw4+Y
         PXUAYh4QdqzK2SUbG9/cLaxJ7/GMHZn91ubYjHynTfO/HLgaxPRpfpvXy9Bmcr6xtCPE
         cgOMNGJen6ll4d2MJWsbkOmHYGCP7YmZMq7N1D/q5PuloGWNlFGirKYx78ND7wDqkLIU
         eKqZDmPgby8bGsTcdT3SWS4mgyW4VbpYnQhQ9nMpa0BkvaiZz3hJSx8x3CXjYuUbMxc3
         HRmhWLylScjQodShvpA+xQjiAMjrmgGM0jH/Mx1KhMtPqz4eajOhSb8hyw9Gdn03OwCU
         ufWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNrKKIEifKOtj0ZTyaBn9IXYDH+TgIsaibPuySrCl9A=;
        b=fPfyu33TQCaoqtxoy2kP3iVzCKPQvlF5RAbZKpueVFcd/MksvkObA/z6EGfzRs8O9K
         0FzyyvH+27JCM+ncY8L6LfEvf/Wi8hRcc8WM5Rv375NBssra8K3yCNGmil0yQaTOIRww
         8rLePLw0hwlqm1MRexKPnaFpm4CqnX5ssv5s0pP7n21KARRmvNtG/eFpjaLeGrukcOZH
         KiNMJub6MJbYPfrY3GAHx/z42BD+2LWy4/0avYuZE4zs6iI42knogCZi1re/kTAOATzi
         DaviUcy46jYu5YUcHlVr1a9rSy3rSLaKu6sqg/YUaFbNSJA9gWefpGP7C3sEjDJ9V2BV
         +Wag==
X-Gm-Message-State: AO0yUKVbkfpZmkfZNoEjHBpbi0aKMDr1cnSDj+IlWHw83fiEjdbl6YrF
        GiOGDXmQy4fiPCc7vlplAJxiwMWg1lr6T9ByApY=
X-Google-Smtp-Source: AK7set+QEu8eiJsyukUuGBuGdN9zcxcewEe6LC4u/BLo8BbI5vnU+nA6liH5QBGNw9h0R3QU0+C7QBqtx8QqSrU52pI=
X-Received: by 2002:a17:907:11dd:b0:8af:3e28:acc with SMTP id
 va29-20020a17090711dd00b008af3e280accmr30378ejb.1.1676413078769; Tue, 14 Feb
 2023 14:17:58 -0800 (PST)
MIME-Version: 1.0
Sender: beatricecarlin64@gmail.com
Received: by 2002:a17:907:c686:b0:85d:6a6e:66e5 with HTTP; Tue, 14 Feb 2023
 14:17:58 -0800 (PST)
From:   Daryna Olga <olgadaryna957@gmail.com>
Date:   Tue, 14 Feb 2023 14:17:58 -0800
X-Google-Sender-Auth: F7_j6BBFvH0UWQEuObdRpCy0uXo
Message-ID: <CA+qmXqcM4KmpVD45eLVmJykDGPvEmoFEtX+kJKpQiPOhBGbnmQ@mail.gmail.com>
Subject: Daryna Olga from Ukraine
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5048]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [beatricecarlin64[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [beatricecarlin64[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello, My name is Ms. Daryna Olga from Ukraine.


I have 100 Kilogrammes of Gold Bars. I plan to negotiate with you, so
that the Gold Bars will be delivered to you in your country and sell
it on my behalf and invest with the Funds in your country because I
want to relocate my late Father's business due to the ongoing war in
my country Ukraine and visit your country.


Thank you as I wait to hear from you soon so I can tell you more
details. God bless you for your care. Contact me through my Private
Email Address: DarynaOlga@gmx.com

Best Regards
Daryna Olga from Ukraine.
