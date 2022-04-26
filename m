Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D55106D8
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Apr 2022 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbiDZS3v (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Apr 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351471AbiDZS3u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 14:29:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F94338B5
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 11:26:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h8so1051484iov.12
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3s1PAi7yaAKLLAwJqzdidADYs8xi+3Y8OeD8v9frsHc=;
        b=XpYBmrmLBjqS+MFAMICt2BGkzCdQlLFQ/jht6JIBVCTIM9a/5tWDscDB/pLzdX2bnt
         f0uxPTUHRSjTNlkAbt3Ni2Z4qgwBaLClOgf6uM4rzxJFdAR+viSFyG9eIeI0Ugtr4GmV
         p3N1wClUAEiYELK1V7kWp4sly57L2131ZZk6aBnpPnqEZBHObeD2GutfdUbojtcH1bJp
         AxnKBwcPDr7TXXO+AA982woqXiTpI69XcJq4NLGgPjT9AD5aIm7SnZJROeKxjJIqp3Qa
         mywDaycsVm/2fHvDcvSdGpxccHpuCGQk9JjpOA0bn9m87c9hMHxJWozVV8nZKfc3M4j5
         9bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=3s1PAi7yaAKLLAwJqzdidADYs8xi+3Y8OeD8v9frsHc=;
        b=430XqDsQpqEfFvtvgu6iNqrDQ3hDqr7p4tPFFDhJI5h7UXROVhunMlEshiDIsWxbFL
         DFYJ9Vha/K7+ZJRF/rp0objhY+3EYPrEBJLak8skCoyf2RSeF8icGOSKCXmq4Zd3PzJB
         2IwYQXYzpOz+EXSYy1ryLJ5x4ai4hVP1QZhJTOrxnBZRMt7ENy+AZGs49AtQDWdMjLOV
         JcZHEl89Bx04Ue0U9erWY/iE2QKaZLF9RN+o1ojzWf/5XGKErMZt8Hxy/M7RqPKPejkB
         nNwm+UhBNtorfvR99QaMRiH4DmvuVAxMpti1BnIJ8iHx4PqP/rZ/v9UUbfQDKxacE6Zb
         e1iA==
X-Gm-Message-State: AOAM531ObUDoMw774HcOk+WAOn33zkX/Z6UMVkhAJ0nKzz2HL7Z0ypK6
        cghyf/qTqxJiXQ/SglqMvJ3mXCDMVR6ZHdpk8Ew=
X-Google-Smtp-Source: ABdhPJxq7tqsIchF5O9ka52FH+plIESV4cuACRFBoBbN+AjqUMueDPd+Vz12a+dUDX65MRCfBp4O7bMzhlDKxV68NqE=
X-Received: by 2002:a05:6638:2103:b0:32a:a4f8:6e6e with SMTP id
 n3-20020a056638210300b0032aa4f86e6emr10835827jaj.81.1650997601970; Tue, 26
 Apr 2022 11:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b747:0:0:0:0:0 with HTTP; Tue, 26 Apr 2022 11:26:41
 -0700 (PDT)
Reply-To: sgtkaylamanthey50@gmail.com
From:   Sgt Kayla Mantheym <kristengriest2255@gmail.com>
Date:   Tue, 26 Apr 2022 18:26:41 +0000
Message-ID: <CAOAm3Rmj2_EuR8+nVazuq5cUQAAif_FXjvrhHcyzYw2+qx0N8w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4792]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kristengriest2255[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylamanthey50[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kristengriest2255[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hell=C3=B3, hogy vagy ma, rem=C3=A9lem, j=C3=B3l vagy, j=C3=B3 eg=C3=A9szs=
=C3=A9ggel, megkaptad az
utols=C3=B3 =C3=BCzenetem?
