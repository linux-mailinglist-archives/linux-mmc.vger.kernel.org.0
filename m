Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB75B4B76
	for <lists+linux-mmc@lfdr.de>; Sun, 11 Sep 2022 05:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIKDgl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 10 Sep 2022 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIKDgk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Sep 2022 23:36:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421125C52
        for <linux-mmc@vger.kernel.org>; Sat, 10 Sep 2022 20:36:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so9988131wrx.8
        for <linux-mmc@vger.kernel.org>; Sat, 10 Sep 2022 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=xwqmK82VVcqmMmWwbD+7n88AG8TOFFD7V80sX2QdR8U=;
        b=d2xrncqzEY96tx/SAX5LmD+YxRnpHAb5GXk+iZ7HGD8Mk7jSkzchhNxM54SZY7S6NS
         lx8oDHoDTynmds2AcgJFJJiPtFxLcuC6xQi2m0/SZsEw1TjA4JO/0cgOjMsV0B3pS25H
         DbMrGSDio3fx1fHVOxWXl3FU9YrbhsbNA9OS3dGi4cyd++N6x2d/ItLGIcisIiHH3IIv
         XJldsHREq5ORRc5Ca2tPZ7BoqBOgzFgmKJewhRBldIeJLKsNJrkdZhiaOXFDAr+NL6kY
         1F8F2s6RPLjDwrGyp0WqJWm3/tNzRTUOpdX3L9yAAnFJ9xAQA0+dvf792pL4F1ljE5Al
         prKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xwqmK82VVcqmMmWwbD+7n88AG8TOFFD7V80sX2QdR8U=;
        b=umkJKOC0oxYexOmUjkVPqdslx+cs6lLqga4RFC2gCcSuXAU30qnZa2Mwa3tskA8UDQ
         Xli0OLjfoJOxKUZ6jDbKwhnov4gyi7C4xSy7W+C+DD3fbBs3ZigBUEq4W7jzzhveDF8/
         YuzM2iX98KxcYnARI0SBkwHBwP0FWf6JBtd4dx3DXnDkQ4NB+pIKBZDH6I1gpjRxv4Ty
         RkT+95omdjE9vsWIseFonKOmAKh0LGXo/Dc8p6EInJbc0n/kxciSgDjYwnX+ssPT0KiO
         dHrx1Ecqgabx4KsUqDM/Kn6Tjo0nzhNtvrfBszoFCas+8DkiB9WaCrA9CoT76SKHMUtD
         oWRw==
X-Gm-Message-State: ACgBeo18ZqqxZk3lfH6hD/caD7GawgI7Ml2YZV2JyMgabtncaqB2YmPX
        dxIYTUtcSqQRcz0UNdZrmRI4+zC47t4ZJx6OQhU=
X-Google-Smtp-Source: AA6agR7eGUe2WQtufGIrcRjuuvzaPuQOd4/7oeS4CJD9jhMrfYxBFBqjPebdZcPEJyL65lCQKFqmIGWTgv2f70dMafo=
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id
 m5-20020a5d6245000000b0022541aea930mr11861721wrv.342.1662867397140; Sat, 10
 Sep 2022 20:36:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:716:0:0:0:0 with HTTP; Sat, 10 Sep 2022 20:36:36
 -0700 (PDT)
Reply-To: izzatibrahim724@gmail.com
From:   Izzat Ibrahim <malickthiam235@gmail.com>
Date:   Sun, 11 Sep 2022 03:36:36 +0000
Message-ID: <CAOt_Vvu300k-jMAdkOu1ePs1Bqv_e701HRWdbxzkaKUoAcfrYg@mail.gmail.com>
Subject: Thanks
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42b listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8522]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [izzatibrahim724[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [malickthiam235[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [malickthiam235[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ATTENTION:

Have you any viable business plan that needs funding? I am acting on
behalf of a family who are cautious due to political and personal
reasons. Be assured that more details will be revealed on showing
interest.

For the safety of their funds the family will be willing to invest or
fund in both short and long term projects. Should you be interested to
engage us for a more detailed discussion on the aforementioned
proposal, we would be glad to do so in whatever medium appropriate for
this engagement.

The funds will be released through bank to bank transfer upon proof of
feasibility study conformable to be viable and demonstration of
managerial skill to prove that the principal amount being invested
will be secured,

Due to the above mentioned reasons (political and personal) we implore
for confidentiality as we look forward to your response. Please
contact me with the below alternative email
(izzatibrahim724@gmail.com)

We look forward towards receiving your proposal/feasibility study.

Regards,

Ibrahim I . Hassan
