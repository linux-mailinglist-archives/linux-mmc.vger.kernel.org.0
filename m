Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC34D7FAC
	for <lists+linux-mmc@lfdr.de>; Mon, 14 Mar 2022 11:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbiCNKTS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 14 Mar 2022 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiCNKTR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 06:19:17 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075AC240A2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-2dc348dab52so156687267b3.6
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=QLLsRy/dmyqoI0RxbutlRZI/KB6PQe9IvOCU+8CAeBQGMyqmF6/tAgeCdcEdZZWTQR
         +lM4dx52NBCcTyQ2m0WfXEwW0vNy/Q2h5+2c+HanumuiwHWZmSKPKFlw44pXKTJtml+R
         dwkeF3hAq1OG1XPpJqiioazUaaQX+JYj0dZPXjKsK11KQt1mm6NBeApJvW01vlTwCTmr
         0zavqxu3N8bMBLwVdJob1TzN3h9Ad2e2PR9EIiqawtuU/tja8f0QInngMnTjQrwOBH97
         yAIfAPxmHT/edHFTmHy/X6VQzKIXHrAJ5+snD7BUcPM2WrhmxfSgG3hq1NGxgIWRcIi2
         0/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=ivHNHTTpkrXDb9yp5uZSLn8fTcW3lv0YovZyDSrLkd6xDxj4QvuoHPqeI4xUeF/b1V
         bMXSQpBVpcG1zaTITO8a5ppcSXsPosJJHJRK1cknwpT+xO5DG+C0+xDim5an3nFgQ4gR
         ad+T7RnukFqBE4FfMQK5KsDdqdbZtXuhhY2nAbogspf0zF6SlHN/SZ1cCbM7J9GmjPGV
         lbKzRUzVl84+zBw8gtcx4I2eDmwAQGk1NtUtJtcZxrlNXdepHo2BBt9DzI+K1mQlOHDP
         6eNGYkH2cXhyif3uXSwEJx5YZtM5gMnjh2bfUjV4HPa3ym0Hrgh+0k1t6ao0IdNul0+G
         gNkA==
X-Gm-Message-State: AOAM533mMQMmmR8r1ALG12cZxYbUbT35G7h0uDgkO0GaM7P2PAA7Iwcx
        SVdkkE7XCO7VXdHXiU3Xy3Icq0Dhm0EBvjZQcNc=
X-Google-Smtp-Source: ABdhPJxt3sbAxxrwf4Yfrv8UBK0gVaHR239NIWyNSkIxk2Sc5EP6VOe5GgMUyXsnR38oFmRN2oH1ymMI9cBZdKCj6G0=
X-Received: by 2002:a81:738a:0:b0:2dc:2bf4:76b0 with SMTP id
 o132-20020a81738a000000b002dc2bf476b0mr17333592ywc.296.1647253085893; Mon, 14
 Mar 2022 03:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:664e:0:0:0:0 with HTTP; Mon, 14 Mar 2022 03:18:05
 -0700 (PDT)
Reply-To: lawrencetansanco.y@gmail.com
From:   Lawrence Tansanco Yacouba <ltansancoy@gmail.com>
Date:   Mon, 14 Mar 2022 10:18:05 +0000
Message-ID: <CAK5Y89B_nM=NB3F74FU=OkW46S8+sqUpfZMbv5ei+DSF9F90LA@mail.gmail.com>
Subject: THANKS FOR YOUR RESPONSE AND GOD BLESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

.
I will like to disclose something very important to you,
get back for more details please.

Regards.
Mr Lawrence Tansanco Y.
