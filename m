Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E764448D
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Dec 2022 14:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLFNb4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 6 Dec 2022 08:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiLFNbz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 08:31:55 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E278F2250B
        for <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2022 05:31:53 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3b5d9050e48so151959757b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 06 Dec 2022 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=OeyCMsHYScRvVh8RXebzMnb6pRDfFrPhGFM5Oo/oZrwyoa5Qe6A4MFoFU3Mp0QEA1i
         SYxbR4sBY6B2f4vL1OEJybUifemEqA8IjQX2J09dxjCQRODPxlkwi9ZEZSAu9TEhort/
         rwllpgNt60odz5Nl0j8spOK2S4UH94zHMFD6KX6br/bHNI2fZHIzqWvZlcUTMKyD9vqw
         pbBkxrH6eRDakHg6i3SDW/XG3pxdEfflEK99JxjqsHbJ7YAIkEj/5S6ueT5UYlPSmqQ/
         Hub6z0zknduscVyttBCDKyxn8xzrz/kgtfd7lHkiDU9nHicul2vZth5Aja6oh/8jcMGO
         G90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=S++tCzqVcJ6nnOEug+QXz9ZmupShoYpZDOXnWIBPE5bOiR/Zu5XOdyxM6Wqind+We6
         q6ZOEisszKg3FLpEpABp7E3lFXkh2/6PAOZ7D+YIn4HBnCXOOsCcJTnl9LH9e+49D/yH
         zJWgqrnDLDrnvK9/FxBS7Ub2OmDFcHVuLTjH3fJU32EFeDNy8ixY+rbFzk69zld+XLaL
         w6qOLIgmWCLxHVvX3umrlZHmZT+Os1IyOR5LfoHkRksUADgKdYlPPXA3u8kzVUK8MIbm
         OZC6k8QUH+umOca0cODaRxWnTguiouTnpmx6GH/KdfgdpsqcUSdQfPHnrhiiO/QzSGYV
         ci1A==
X-Gm-Message-State: ANoB5plrQCSQ30JZc6r91rKOEOeXO4YG75BXOlrLGJMMAvz9X3Gk+eqr
        f/cssMiaZeCkM71yU9K3sgQ03F6D2d4tmhajJxs=
X-Google-Smtp-Source: AA0mqf7Z2Y5k3chtNt8kbVNLNOAPCXtgRbw0oMU6LK5Q/RiR2Ia6QNch2ZuKx5+xFv9D2teTY/76/SaSp4zD3zNfpik=
X-Received: by 2002:a81:5243:0:b0:3d2:2098:c5fb with SMTP id
 g64-20020a815243000000b003d22098c5fbmr31214777ywb.121.1670333513086; Tue, 06
 Dec 2022 05:31:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a205:b0:314:d2a3:70a with HTTP; Tue, 6 Dec 2022
 05:31:52 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrkojofofone01@gmail.com>
Date:   Tue, 6 Dec 2022 13:31:52 +0000
Message-ID: <CACJtp8vgE8Nrmo+zWDrnXRqoM_o=MmruUY09Qi=4vFfLMPDrtA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
